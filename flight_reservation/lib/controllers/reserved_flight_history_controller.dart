import 'package:flight_reservation/db/flights_database_helper.dart';
import 'package:flight_reservation/db/reserve_flight_database_helper.dart';
import 'package:flight_reservation/models/flight_model.dart';
import 'package:flight_reservation/models/reserve_model.dart';
import 'package:flight_reservation/utils/common_code.dart';
import 'package:flight_reservation/widgets/custom_progress_dialogue.dart';
import 'package:get/get.dart';

class ReservedFlightHistoryController extends GetxController {
  RxList<ReserveModel> reservedFlights = <ReserveModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchReservedFlights();
    super.onInit();
  }

  void fetchReservedFlights() async {
    isLoading.value = true;
    reservedFlights.value =
        await ReserveFlightDatabaseHelper().getReserveFlightList();
    isLoading.value = false;
  }

  void onRemoveClick(int index) async {
    ProgressDialog().showDialog();
    try {
      await ReserveFlightDatabaseHelper()
          .deleteReserveFlight(reservedFlights[index].id);
      fetchReservedFlights();
      await FlightDatabaseHelper()
          .getFlight(reservedFlights[index].flightID)
          .then((flight) async {
        FlightModel flightModel = flight;
        flightModel.availableSeat = flightModel.availableSeat + 1;
        flightModel.reservedById = '';
        await FlightDatabaseHelper().updateFlight(flightModel);
        
      });
      ProgressDialog().dismissDialog();
      CommonCode().showToast(message: 'Flight Cancel successfully');
    } catch (e) {
      ProgressDialog().dismissDialog();
      CommonCode().showToast(message: 'Exception occurred: $e');
    }
  }
}
