import 'package:flight_reservation/controllers/login_controller.dart';
import 'package:flight_reservation/screens/auth.dart/sign_up_screen.dart';
import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flight_reservation/widgets/custom_app_bar.dart';
import 'package:flight_reservation/widgets/custom_button.dart';
import 'package:flight_reservation/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GestureDetector(
      onTap: () {
        controller.removeFocus();
      },
      child: Scaffold(
        appBar: CustomAppbar(
          screenName: 'Log In',
          scaffoldKey: controller.scaffoldKey,
          isDrawerVisible: false,
          appBarHeight: 50,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextField.withBorder(
                    tfManager: controller.emailManager),
                Obx(
                  () => CustomTextField.withBorder(
                    tfManager: controller.passwordManager,
                    isObscure: controller.obscureText.value,
                    suffixIcon: controller.obscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixIconTap: () {
                      controller.onObscureText();
                    },
                  ),
                ),
                CustomButton(
                    onPressed: controller.onLoginClick, text: 'Log In'),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const SignUpScreen());
                          },
                        style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
