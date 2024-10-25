// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flight_reservation/controllers/sign_up_controller.dart';
import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flight_reservation/widgets/custom_app_bar.dart';
import 'package:flight_reservation/widgets/custom_button.dart';
import 'package:flight_reservation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return GestureDetector(
      onTap: () {
        controller.removeFocus();
      },
      child: Scaffold(
        appBar: CustomAppbar(
          screenName: 'Sign Up',
          scaffoldKey: controller.scaffoldKey,
          isDrawerVisible: false,
          appBarHeight: 50,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextField.withBorder(
                    tfManager: controller.firstNameManager),
                CustomTextField.withBorder(tfManager: controller.lastNameManager),
                CustomTextField.withBorder(tfManager: controller.emailManager),
                CustomTextField.withBorder(
                    tfManager: controller.phoneManager),
                CustomTextField.withBorder(
                    tfManager: controller.passwordManager),
                Obx(
                  () => CustomCheck(
                    text:
                        'I agree with all privacy policies \nAnd terms and condition',
                    onCheck: (value) {
                      controller.isAgreed.toggle();
                    },
                    isCheck: controller.isAgreed.value,
                  ),
                ),
                CustomButton(
                    onPressed: controller.onRegisterClick, text: 'Sign Up'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCheck extends StatelessWidget {
  final Function(bool?) onCheck;
  final bool isCheck;
  final String text;
  const CustomCheck({
    Key? key,
    required this.onCheck,
    required this.isCheck,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isCheck,
          onChanged: onCheck,
          checkColor: Colors.white,
          activeColor: AppColor.primaryColor,
          focusColor: AppColor.primaryColor2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColor.greyColor1),
        )
      ],
    );
  }
}

