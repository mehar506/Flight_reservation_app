import 'package:flight_reservation/screens/auth.dart/log_in_screen.dart';
import 'package:flight_reservation/screens/home_screen.dart';
import 'package:flight_reservation/screens/reserved_flight_history_screen.dart';
import 'package:flight_reservation/utils/user_session.dart';
import 'package:flight_reservation/widgets/custom_dialogs.dart';
import 'package:get/get.dart';

class CustomEndDrawerController extends GetxController {
  Future<void> onTap(String title) async {
    Get.back();
    if (title == 'Logout') {
      CustomDialogs().confirmationDialog(
          message: "Are you sure want to Logout?",
          yesFunction: () {
            UserSession().logout();
            Get.offAll(() => const LoginScreen());
          });
    }else if (title == 'See All Flights') {
      Get.offAll(() => const HomeScreen());
    }
     else if (title == 'Reservations History') {
      Get.offAll(() => const ReservedFlightHistoryScreen(),
          predicate: (r) => r.isFirst);
    } else if (title == 'Settings') {
      CustomDialogs().confirmationDialog(
          message: "Settings is under development.",
          yesFunction: () {
            Get.back();
          });
    }
  }
}
