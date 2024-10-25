import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CommonCode {
  
  Widget showProgressIndicator(
      bool visibility, bool isListEmpty) {
    return visibility
        ? Visibility(
            visible: visibility,
            child: Padding(
                padding:
                    EdgeInsets.only(top: isListEmpty ? Get.height * 0.3 : 20),
                child: const Center(
                    child: CircularProgressIndicator(
                        color:AppColor.primaryColor, strokeWidth: 2))))
        : Visibility(
            visible: isListEmpty,
            child: Container(
              alignment: Alignment.center,
              height: Get.height * 0.3,
              child:  Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 40,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const SizedBox(height: 10),
                  Text(
                   'No Listing Found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void showSuccessToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.greenColor,
      textColor: Colors.white,
      fontSize: 13.0,
    );
  }

  void showToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xF9454141),
        textColor: Colors.white,
        fontSize: 13.0);
  }

 
}
