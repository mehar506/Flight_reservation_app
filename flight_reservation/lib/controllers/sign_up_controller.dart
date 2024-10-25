import 'package:flight_reservation/db/flights_database_helper.dart';
import 'package:flight_reservation/db/passenger_database_helper.dart';
import 'package:flight_reservation/models/passenger_model.dart';
import 'package:flight_reservation/screens/auth.dart/log_in_screen.dart';
import 'package:flight_reservation/utils/common_code.dart';
import 'package:flight_reservation/utils/dummy_data.dart';
import 'package:flight_reservation/utils/text_field_manager.dart';
import 'package:flight_reservation/utils/text_filter.dart';
import 'package:flight_reservation/widgets/custom_progress_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldManager firstNameManager =
      TextFieldManager('First Name', length: 50, filter: TextFilter.name);
  TextFieldManager lastNameManager =
      TextFieldManager('Last Name', length: 50, filter: TextFilter.name);
  TextFieldManager emailManager =
      TextFieldManager('Email', length: 50, filter: TextFilter.email);
  TextFieldManager phoneManager =
      TextFieldManager('Phone No', length: 50, filter: TextFilter.mobile);
  TextFieldManager passwordManager =
      TextFieldManager('Password', length: 50, filter: TextFilter.none);

  RxBool isUser = true.obs;
  RxBool isAgreed = false.obs;

  bool agreedValidate() {
    if (isAgreed.isTrue) {
      return true;
    } else {
      CommonCode().showToast(message: "must be agree before sign up");
      return false;
    }
  }

  void onRegisterClick() async {
    if (firstNameManager.validate() &
        lastNameManager.validate() &
        emailManager.validate() &
        phoneManager.validate() &
        passwordManager.validate()) {
      if (isAgreed.value) {
        ProgressDialog pd = ProgressDialog()..showDialog();
        int id = DateTime.now().millisecondsSinceEpoch;
        PassengerModel passengerModel = PassengerModel(
            id: id,
            firstName: firstNameManager.controller.text,
            lastName: lastNameManager.controller.text,
            email: emailManager.controller.text,
            phone: phoneManager.controller.text,
            password: passwordManager.controller.text);
        try {
          await FlightDatabaseHelper().initializeFlightDatabase().then((value) async{
            DummyData.flights.forEach((flight) async {
              await FlightDatabaseHelper().insertFlight(flight);
            });
          });
          await PassengerDatabaseHelper()
              .initializePassengerDatabase()
              .then((value) async {
            await PassengerDatabaseHelper()
                .insertPassenger(passengerModel)
                .then((value) {
              pd.dismissDialog();
              CommonCode().showToast(message: 'Sign up successful');
              Get.offAll(() => const LoginScreen());
            });
          });
        } catch (e) {
          pd.dismissDialog();
          CommonCode().showToast(message: 'Sign up failed ${e.toString()}');
        }
      } else {
        CommonCode().showToast(message: 'First Agree Then Sign up');
      }
    }
  }

  void removeFocus() {
    if (firstNameManager.focusNode.hasFocus) {
      firstNameManager.focusNode.unfocus();
    }
    if (lastNameManager.focusNode.hasFocus) {
      lastNameManager.focusNode.unfocus();
    }
    if (phoneManager.focusNode.hasFocus) {
      phoneManager.focusNode.unfocus();
    }
    if (emailManager.focusNode.hasFocus) {
      emailManager.focusNode.unfocus();
    }
    if (passwordManager.focusNode.hasFocus) {
      passwordManager.focusNode.unfocus();
    }
  }
}
