import 'package:flight_reservation/db/flights_database_helper.dart';
import 'package:flight_reservation/db/reserve_flight_database_helper.dart';
import 'package:flight_reservation/models/flight_model.dart';
import 'package:flight_reservation/models/reserve_model.dart';
import 'package:flight_reservation/utils/common_code.dart';
import 'package:flight_reservation/utils/user_session.dart';
import 'package:flight_reservation/widgets/custom_progress_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxList<FlightModel> flights = <FlightModel>[].obs;
  final TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    getFlights();
    super.onInit();
  }

  void onSearchClick() async {
    ProgressDialog().showDialog();
    if (searchController.text.isEmpty) {
      getFlights();
    } else {
      List<FlightModel> flightList = [];
      flightList = flights
          .where((element) => element.arrivalCity
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      flights.value = flightList;
    }
    ProgressDialog().dismissDialog();
  }

  void getFlights() async {
    isLoading.value = true;
    try {
      List<FlightModel> flightList = [];
      flightList = await FlightDatabaseHelper().getFlightList();
      flights.value = flightList;
      flights.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CommonCode().showToast(message: 'Exception occurred: $e');
    }
  }

  void onBookClick(FlightModel flightModel) async {
    if (flightModel.reservedById.isNotEmpty) {
      CommonCode().showToast(
          message:
              'Flight already booked if you want to cancel then go reserve history page.');
      return;
    }
    ProgressDialog().showDialog(title: 'Booking Flight.......');
    int id = DateTime.now().millisecondsSinceEpoch;
    int passengerID = UserSession.passengerModel.value.id;
    try {
      ReserveModel reserveModel = ReserveModel(
          id: id,
          passengerID: passengerID,
          flightID: flightModel.id,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          seat: flightModel.availableSeat.toString(),
          price: flightModel.price.toString());
      await ReserveFlightDatabaseHelper()
          .insertReserveFlight(reserveModel)
          .then((value) async {
        if (value != -1) {
          ProgressDialog().dismissDialog();
          FlightModel newFlight = flightModel;
          newFlight.availableSeat = flightModel.availableSeat - 1;
          newFlight.reservedById =
              UserSession.passengerModel.value.id.toString();
          await FlightDatabaseHelper().updateFlight(newFlight);
          getFlights();
          ProgressDialog().dismissDialog();
          CommonCode().showToast(message: 'Flight booked successfully');
        } else {
          ProgressDialog().dismissDialog();
          CommonCode().showToast(message: 'Failed to book flight');
        }
      });
    } catch (e) {
      ProgressDialog().dismissDialog();
      CommonCode().showToast(message: 'Exception occurred: $e');
    }
    ProgressDialog().dismissDialog();
  }
}
