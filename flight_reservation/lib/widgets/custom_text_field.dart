import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flight_reservation/utils/text_field_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextFieldManager tfManager;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final int maxLines;
  final double paddingHorizontal;
  final bool readOnly;
  final bool isObscure;
  final RxBool _withShadow = RxBool(false);

  CustomTextField.withBorder(
      {Key? key,
      required this.tfManager,
      this.suffixIcon,
      this.onSuffixIconTap,
      this.maxLines = 1,
      this.isObscure = false,
      this.paddingHorizontal = 4,
      this.readOnly = false})
      : super(key: key);

  CustomTextField.withShadow(
      {Key? key,
      required this.tfManager,
      this.suffixIcon,
      this.onSuffixIconTap,
      this.maxLines = 1,
      this.isObscure = false,
      this.paddingHorizontal = 4,
      this.readOnly = false})
      : super(key: key) {
    // _withShadow.value=true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(tfManager.hint==null) RichText(text: TextSpan(text: tfManager.fieldName,
            style: const TextStyle(color: kTextColor),
            children: tfManager.mandatory ? [
              const TextSpan(text: '*', style: TextStyle(color: kRequiredRedColor, fontWeight: FontWeight.bold))
            ] : null,
          ),),
          // Text(tfManager.fieldName, style: const TextStyle(color: kBlackColor, fontSize: 14),),
          Obx(
            () => Container(
              width: Get.width,
              margin: const EdgeInsets.only(top: 4),
              padding:
                  EdgeInsets.only(left: _withShadow.isFalse ? 12 : 8, right: 2),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_withShadow.isTrue ? 20 : 4),
                  border: _withShadow.isTrue
                      ? null
                      : Border.all(
                          color: /*tfManager.errorMessage.isNotEmpty ? kRequiredRedColor : */
                              kFieldBorderColor),
                  color: readOnly
                      ? kFieldGreyColor
                      : _withShadow.isTrue
                          ? kWhiteColor
                          : kFieldGreyColor,
                  boxShadow: _withShadow.isTrue
                      ? [
                          const BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1,
                              color: kFieldShadowColor)
                        ]
                      : null),
              child: SizedBox(
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: tfManager.keyboardType,
                        maxLines: maxLines,
                        obscureText: isObscure,
                        minLines: maxLines > 2 ? 3 : null,
                        readOnly: readOnly,
                        maxLength: tfManager.length,
                        controller: tfManager.controller,
                        focusNode: tfManager.focusNode,
                        textCapitalization: tfManager.textCapitalization,
                        onChanged: (value) {
                          tfManager.validate();
                        },
                        textInputAction: maxLines == 1
                            ? TextInputAction.done
                            : TextInputAction.newline,
                        inputFormatters: tfManager.formatters,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: tfManager.hint ?? tfManager.fieldName,
                          // contentPadding: const EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: kTextHintColor),
                        ),
                        style: TextStyle(
                            color: readOnly ? kGreyColor : kBlackColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4, vertical: maxLines == 1 ? 11 : 6),
                      child: suffixIcon != null &&
                              tfManager.errorMessage.isEmpty
                          ? InkWell(
                              onTap: onSuffixIconTap,
                              child: Icon(suffixIcon, color: kTextHintColor),
                            )
                          // : tfManager.errorMessage.isNotEmpty && _withShadow.isFalse
                          // ? const Icon(Icons.info, color: kRequiredRedColor)
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Visibility(
                visible: tfManager.errorMessage.value.isNotEmpty,
                child: Text(
                  tfManager.errorMessage.value,
                  style:
                      const TextStyle(color: kRequiredRedColor, fontSize: 12),
                ),
              )),
        ],
      ),
    );
  }
}
