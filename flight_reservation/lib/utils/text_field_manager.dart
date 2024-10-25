import 'package:flight_reservation/utils/text_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldManager {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  RxString errorMessage = ''.obs;
  String fieldName;
  TextInputType _textInputType = TextInputType.name;
  bool Function()? customValidation;
  int length;
  String? hint;
  TextCapitalization textCapitalization = TextCapitalization.none;

  TextFilter filter;
  List<TextInputFormatter>? _formatters;
  bool mandatory;

  TextFieldManager(this.fieldName,
      {this.filter = TextFilter.none,
      this.mandatory = true,
      this.length = 30,
      this.hint}) {
    if (filter == TextFilter.number) {
      _formatters = [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
      _textInputType = TextInputType.number;
      customValidation = validateNumber;
    } else if (filter == TextFilter.name) {
      _formatters = [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]'))];
      textCapitalization = TextCapitalization.words;
      _textInputType = TextInputType.name;
    } else if (filter == TextFilter.alphaNumeric) {
      _formatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9 ]'))
      ];
      textCapitalization = TextCapitalization.sentences;
      _textInputType = TextInputType.text;
    } else if (filter == TextFilter.email) {
      _formatters = [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
      _textInputType = TextInputType.emailAddress;
      customValidation = validateEmail;
    } else if (filter == TextFilter.mobile) {
      length = 11;
      _formatters = [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
      _textInputType = TextInputType.number;
      customValidation = validateMobileNumber;
    } 
  }

  List<TextInputFormatter>? get formatters => _formatters;

  TextInputType get keyboardType => _textInputType;

  String get text => controller.text.trim();

  bool validate() {
    if (customValidation != null) {
      return customValidation!();
    }
    if (text.isEmpty) {
      errorMessage.value = mandatory ? "$fieldName is Required!" : '';
    } else {
      // UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    }
    return errorMessage.isEmpty;
  }
  bool validateEmail() {
    if (text.isEmpty) {
      errorMessage.value = mandatory ? "Email Address is required!" : "";
    } else if (!text.isEmail) {
      errorMessage.value = "Invalid Email Address!";
    } else {
      errorMessage.value = "";
    }
    return errorMessage.isEmpty;
  }

  bool validateMobileNumber() {
    if (text.isEmpty) {
      errorMessage.value = mandatory ? "Mobile No is required!" : "";
    } else if (RegExp(r'^[0][3][0-5][0-9]{8}$').hasMatch(text)) {
      errorMessage.value = "";
    } else {
      errorMessage.value = "Mobile No must follow '03XXXXXXXXX' format!";
    }

    return errorMessage.isEmpty;
  }

  bool validateNumber() {
    if (text.isNotEmpty) {
      double d = double.tryParse(text) ?? 0;
      controller.text = d.ceil().toString();
      controller.selection =
          TextSelection(baseOffset: text.length, extentOffset: text.length);
      errorMessage.value = "";
    } else {
      errorMessage.value = mandatory ? "$fieldName is required!" : "";
    }
    return errorMessage.isEmpty;
  }

  bool validateUSMobileNumber() {
    if (text.isEmpty) {
      errorMessage.value = mandatory ? "Mobile No is required!" : "";
    } else if (RegExp(
            r'^(?:\+?1[-.\s]?)?\(?([2-9][0-8][0-9])\)?[-.\s]?([2-9][0-9]{2})[-.\s]?([0-9]{4})$')
        .hasMatch(text)) {
      errorMessage.value = "";
    } else {
      errorMessage.value =
          "Mobile No must follow US format (e.g., XXX-XXX-XXXX)!";
    }
    return errorMessage.isEmpty;
  }
}
