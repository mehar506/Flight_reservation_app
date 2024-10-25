import 'package:flight_reservation/controllers/custom_end_drawer_controller.dart';
import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flight_reservation/utils/user_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomEndDrawer extends GetView<CustomEndDrawerController> {
  const CustomEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CustomEndDrawerController());
    return Drawer(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        // bottomRight: Radius.circular(20)
      )),
      backgroundColor: AppColor.greenColor.withAlpha(235),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                right: 15,
                left: 18,
                top: 24 + MediaQuery.of(context).padding.top,
                bottom: 20),
            child: Column(
              children: [
                Container(
                  width: 86,
                  padding: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x44444444),
                          blurRadius: 1.5,
                          spreadRadius: 1.5)
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70.0),
                    child: Image.asset(
                      "assets/images/home.jpg",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${UserSession.passengerModel.value.firstName} ${UserSession.passengerModel.value.lastName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  UserSession.passengerModel.value.email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(36), topRight: Radius.circular(36)),
              child: Container(
                width: double.infinity,
                // padding: const EdgeInsets.only( top: 0, bottom: 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36)),
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 20),
                      _getDrawerNavItem(
                        title: "See All Flights",
                        icon: Icons.home,
                      ),
                      const Divider(indent: 54),
                      _getDrawerNavItem(
                        title: "Reservations History",
                        icon: Icons.history,
                      ),
                      const Divider(indent: 54),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            // width: double.infinity,
            child: Column(
              children: [
                const Divider(thickness: 1, height: 1),
                _getDrawerNavItem(
                  title: "Settings",
                  icon: Icons.settings,
                ),
                _getDrawerNavItem(title: "Logout", icon: Icons.logout_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDrawerNavItem(
      {required String title,
      required icon,
      bool enabled = true,
      bool changeColor = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: enabled ? () => controller.onTap(title) : null,
        child: Row(
          children: [
            Icon(icon, size: 27, color: AppColor.redColor),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black.withAlpha(210),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(CupertinoIcons.forward, color: AppColor.greyColor2),
          ],
        ),
      ),
    );
  }
}
