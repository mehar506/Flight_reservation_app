import 'package:flight_reservation/db/passenger_database_helper.dart';
import 'package:flight_reservation/models/passenger_model.dart';
import 'package:flight_reservation/screens/home_screen.dart';
import 'package:flight_reservation/utils/common_code.dart';
import 'package:flight_reservation/utils/text_field_manager.dart';
import 'package:flight_reservation/utils/text_filter.dart';
import 'package:flight_reservation/utils/user_session.dart';
import 'package:flight_reservation/widgets/custom_progress_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldManager emailManager =
      TextFieldManager('Email', length: 50, filter: TextFilter.email);
  TextFieldManager passwordManager =
      TextFieldManager('Password', length: 50, filter: TextFilter.none);

  RxBool remeberMe = false.obs;
  RxBool isClickRecoverPassword = false.obs;
  RxBool obscureText = true.obs;

  void onLoginClick() async {
    if (emailManager.validate() & passwordManager.validate()) {
      ProgressDialog().showDialog();
      try {
        PassengerModel passengerModel = await PassengerDatabaseHelper()
            .getPassenger(
                emailManager.controller.text, passwordManager.controller.text);
        if (passengerModel.id != -1) {
          await UserSession().createSession(user: passengerModel);
          Get.offAll(() => const HomeScreen());
          CommonCode().showToast(message: 'Login successful');
        } else {
          CommonCode().showToast(message: 'Invalid email or password');
        }
        ProgressDialog().dismissDialog();
      } catch (e) {
        ProgressDialog().dismissDialog();
        CommonCode().showToast(message: 'Exception occurred: $e');
      }
    }
  }

  void onObscureText() {
    if (obscureText.value) {
      obscureText.value = false;
    } else {
      obscureText.value = true;
    }
  }

  void removeFocus() {
    if (emailManager.focusNode.hasFocus) {
      emailManager.focusNode.unfocus();
    }
    if (passwordManager.focusNode.hasFocus) {
      passwordManager.focusNode.unfocus();
    }
  }
}
