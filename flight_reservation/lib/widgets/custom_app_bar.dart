// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String screenName;
  final bool isDrawerVisible;
  final double appBarHeight;
  final Color? backgroundColor;
  final PreferredSize? bottomSheet;
  const CustomAppbar({
    Key? key,
    required this.scaffoldKey,
    this.backgroundColor,
    required this.screenName,
    required this.isDrawerVisible,
    required this.appBarHeight,
    this.bottomSheet,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: (isDrawerVisible)
          ? Padding(
              padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
              child: GestureDetector(
                child: const CircleAvatar(backgroundImage: AssetImage('assets/images/home.jpg')),
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            )
          : null,
      title: Text(
        screenName,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
      ),
      centerTitle: true,
      actionsIconTheme: const IconThemeData(),
      bottom: bottomSheet,
    );
  }
}
