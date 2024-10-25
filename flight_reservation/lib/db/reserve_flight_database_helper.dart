// ignore_for_file: unused_import

import 'dart:io';

import 'package:flight_reservation/models/flight_model.dart';
import 'package:flight_reservation/models/reserve_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ReserveFlightDatabaseHelper {
  static ReserveFlightDatabaseHelper? databaseHelper; // Singleton DatabaseHelper
  static Database? database; // Singleton Database

  ReserveFlightDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory ReserveFlightDatabaseHelper() {
    databaseHelper ??= ReserveFlightDatabaseHelper._createInstance();
    return databaseHelper!;
  }
  
  // Define database name and version
  Future<Database> get getReserveFlightDatabase async {
    database ??= await initializeReserveFlightDatabase();
    return database!;
  }

  // Initialize database
  Future<Database> initializeReserveFlightDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}reserveFlight.db';
    var reserveFlightDatabase =
        await openDatabase(path, version: 1, onCreate: _createReserveFlightDb);
    return reserveFlightDatabase;
  }

  // Create database and table
  void _createReserveFlightDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE reserveFlights(id INTEGER PRIMARY KEY AUTOINCREMENT, passengerID INTEGER, flightID INTEGER, date TEXT, seatNumber TEXT, price TEXT)' );
  }

  // Insert operation
  Future<int> insertReserveFlight(ReserveModel reserveModel) async {
    Database db = await getReserveFlightDatabase;
    var result = await db.insert('reserveFlights', reserveModel.toJson());
    return result;
  }

  // Fetch operation: Get all Reserve Flights
  Future<List<ReserveModel>> getReserveFlightList() async {
    Database db = await getReserveFlightDatabase;
    var result = await db.query('reserveFlights');
    List<ReserveModel> reserveFlightList = result.isNotEmpty
        ? result.map((flight) => ReserveModel.fromJson(flight)).toList()
        : [];
    return reserveFlightList;
  }

  Future<int> deleteReserveFlight(int id) async {
    Database db = await getReserveFlightDatabase;
    return await db.delete('reserveFlights', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllReserveFlights() async {
    Database db = await getReserveFlightDatabase;
    return await db.delete('reserveFlights');
  }

  // Update operation
  Future<int> updateReserveFlight(ReserveModel reserveModel) async {
    var db = await getReserveFlightDatabase;
    var result = await db.update('reserveFlights', reserveModel.toJson(),
        where: 'id = ?', whereArgs: [reserveModel.id]);
    return result;
  }


}