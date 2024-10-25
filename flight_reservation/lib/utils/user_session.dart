import 'dart:convert';
import 'package:flight_reservation/models/passenger_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*Created By: Amjad Jamali on 15-Aug-2023*/
class UserSession {

  static final RxBool isDataChanged = RxBool(false);
  static final Rx<PassengerModel> passengerModel = PassengerModel.empty().obs;

  static final UserSession _instance = UserSession._internal();
  UserSession._internal();
  factory UserSession() {
    return _instance;
  }

  Future<bool> createSession({required PassengerModel user}) async {
    final preference = await SharedPreferences.getInstance();
    passengerModel.value = user;
    preference.setString('USER_DATA', jsonEncode(passengerModel.value.toJson()));
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    final preference = await SharedPreferences.getInstance();
    passengerModel.value = PassengerModel.fromJson(jsonDecode(preference.getString('USER_DATA') ?? "{}"));
    if(passengerModel.value.id==-1) return false;
    return true;
  }

  Future<bool> logout() async {
    final preference = await SharedPreferences.getInstance();
    preference.remove('USER_DATA');
    passengerModel.value = PassengerModel.empty();
    return true;
  }
}
