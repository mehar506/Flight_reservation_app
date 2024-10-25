import 'package:flight_reservation/screens/home_screen.dart';
import 'package:flight_reservation/screens/welcome_screen.dart';
import 'package:flight_reservation/utils/app_asset.dart';
import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flight_reservation/utils/styles/styles.dart';
import 'package:flight_reservation/utils/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double width = Get.width * 0.1;
  double fontSize = 16;

   @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        bool isLoggedIn = await UserSession().isUserLoggedIn();
        if (isLoggedIn) {
          Get.offAll(() => const HomeScreen());
        } else {
          Get.offAll(() => const WelcomeScreen());
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              width: width,
              height: width,
              child: Image.asset(AppAsset.logo('logo_app.png')),
            ),
            Text(
              'Flight Reservation',
              style: TextStyles.title.copyWith(
                color: Colors.white,
                letterSpacing: 8,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
