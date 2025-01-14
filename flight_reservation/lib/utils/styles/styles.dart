import 'package:flight_reservation/utils/styles/colors.dart';
import 'package:flutter/material.dart';

enum TextFieldState { focus, error, disabled, none }

enum InputStyle { box, line, outline }

enum ShimmerStyle { rectangle, circle }

Widget verticalSpace(double v) {
  return SizedBox(height: v);
}

Widget horizontalSpace(double v) {
  return SizedBox(width: v);
}

class AppStyle {
  static ThemeData appTheme(hexColor, splashColor) {
    return ThemeData(
      platform: TargetPlatform.iOS,
      brightness: Brightness.light,
      primaryColor: MaterialColor(hexColor, AppColor.color),
      primarySwatch: MaterialColor(hexColor, AppColor.color),
      splashColor: splashColor,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}

class TextStyles {
  static TextStyle text = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.black,
  );
  static TextStyle get title =>
      text.copyWith(fontWeight: FontWeight.w600, fontSize: 16);

  static TextStyle get desc => text.copyWith(fontSize: 12);

  static TextStyle get button =>
      text.copyWith(fontWeight: FontWeight.w600, fontSize: 16);
}

class Insets {
  static double offsetScale = 1;
  static double get xs => 4;
  static double get sm => 8;
  static double get med => 12;
  static double get lg => 16;
  static double get xl => 20;
  static double get xxl => 32;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Corners {
  static double xs = 4;
  static BorderRadius xsBorder = BorderRadius.all(xsRadius);
  static Radius xsRadius = Radius.circular(xs);

  static double sm = 8;
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius smRadius = Radius.circular(sm);

  static double med = 12;
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius medRadius = Radius.circular(med);

  static double lg = 16;
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius lgRadius = Radius.circular(lg);

  static double xl = 24;
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius xlRadius = Radius.circular(xl);

  static double xxl = 32;
  static BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static Radius xxlRadius = Radius.circular(xxl);
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.13),
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ];
  static List<BoxShadow> get universal2 => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.5),
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.15),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ];
  static List<BoxShadow> get none => [
        BoxShadow(
          color: Colors.grey.shade50,
        ),
      ];

  static List<BoxShadow> get shadowsUp => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.15),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(-1, 0),
        ),
      ];

  static List<BoxShadow> get shadowsDown => [
        BoxShadow(
          color: AppColor.greyColor1.withOpacity(0.5),
          blurRadius: 3,
          offset: const Offset(0, 4),
        ),
      ];
}

InputDecoration inputDecoration({
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  TextStyle? hintStyle,
  EdgeInsets? padding,
  Color? hintColor,
}) {
  return InputDecoration(
    isDense: true,
    // filled: true,
    contentPadding:
        padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    hintText: hintText,
    border: InputBorder.none,
    errorMaxLines: 5,
    prefixIcon: prefixIcon,
    prefixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
    suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
    suffixIcon: suffixIcon,
    hintStyle: hintStyle ??
        TextStyles.text.copyWith(color: hintColor ?? const Color(0xFFC1BABA)),
  );
}
