import 'dart:io';

import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flight_reservation/widgets/custom_app_bar.dart';
import 'package:flight_reservation/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_end_drawer.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final Widget? trailing;
  final String className, screenName;
  final Color? backgroundColor;
  final Function? onWillPop,
      gestureDetectorOnTap,
      onBackButtonPressed,
      gestureDetectorOnPanDown,
      onAddPressed,
      onNotificationListener;
  final Future<void> Function()? onRefresh;
  final bool isDrawerVisible;
  final bool isNavgationBarVisible;
  final ScrollController? scrollController;
  final double horizontalPadding;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double appBarHeight;
  final PreferredSize? bottomSheet;

  const CustomScaffold({
    super.key,
    required this.className,
    required this.screenName,
    this.backgroundColor,
    this.trailing,
    this.onWillPop,
    this.isDrawerVisible = false,
    this.isNavgationBarVisible = false,
    this.onBackButtonPressed,
    this.gestureDetectorOnPanDown,
    this.gestureDetectorOnTap,
    this.onNotificationListener,
    this.onAddPressed,
    this.onRefresh,
    required this.scaffoldKey,
    required this.body,
    this.scrollController,
    this.horizontalPadding = 0,
    this.appBarHeight = 60,
    this.bottomSheet,
  });

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (widget.className == "" && widget.isNavgationBarVisible) {
            if (widget.scaffoldKey.currentState!.isDrawerOpen) {
              Get.back();
            } else {
              CustomDialogs().confirmationDialog(
                  message: "Are you sure you want to exit?",
                  yesFunction: () => exit(0));
            }
            return Future.value(false);
          } else {
            if (widget.onWillPop != null) {
              return widget.onWillPop!();
            } else {
              return Future.value(true);
            }
          }
        },
        child: GestureDetector(
          onTap: () {
            if (widget.gestureDetectorOnTap != null) {
              widget.gestureDetectorOnTap!();
            }
          },
          onPanDown: (panDetails) {
            if (widget.gestureDetectorOnPanDown != null) {
              widget.gestureDetectorOnPanDown!(panDetails);
            }
          },
          child: NotificationListener(
            onNotification: (notificationInfo) {
              if (widget.onNotificationListener != null) {
                return widget.onNotificationListener!(notificationInfo);
              } else {
                return false;
              }
            },
            child: Scaffold(
              drawer: widget.isDrawerVisible ? const CustomEndDrawer() : null,
              extendBody: true,
              resizeToAvoidBottomInset: false,
              key: widget.scaffoldKey,
              backgroundColor: widget.backgroundColor,
              appBar: CustomAppbar(
                screenName: widget.screenName,
                backgroundColor: widget.backgroundColor,
                scaffoldKey: widget.scaffoldKey,
                isDrawerVisible: widget.isDrawerVisible,
                appBarHeight: widget.appBarHeight,
                bottomSheet: widget.bottomSheet,
              ),
              body: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    widget.onRefresh != null
                        ? RefreshIndicator(
                            onRefresh: widget.onRefresh!,
                            color: AppColor.primaryColor,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: widget.onAddPressed == null ? 16 : 64,
                                  left: widget.horizontalPadding,
                                  right: widget.horizontalPadding),
                              child: widget.body,
                            ),
                          )
                        : widget.body,
                  ],
                ),
              ),
              floatingActionButton: widget.onAddPressed == null
                  ? null
                  : FloatingActionButton(
                      onPressed: () => widget.onAddPressed!(),
                      backgroundColor: AppColor.primaryColor,
                      child: const Icon(Icons.add, size: 32),
                    ),
              // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            ),
          ),
        ));
  }
}
