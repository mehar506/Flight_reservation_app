import 'dart:io';

import 'package:flight_reservation/models/flight_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FlightDatabaseHelper {
  static FlightDatabaseHelper? databaseHelper; // Singleton DatabaseHelper
  static Database? database; // Singleton Database

  FlightDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory FlightDatabaseHelper() {
    databaseHelper ??= FlightDatabaseHelper._createInstance();
    return databaseHelper!;
  }
  
  // Define database name and version
  Future<Database> get getFlightDatabase async {
    database ??= await initializeFlightDatabase();
    return database!;
  }

  // Initialize database
  Future<Database> initializeFlightDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}flights.db';
    var flightDatabase = await openDatabase(path, version: 2, onCreate: _createFlightDb);
    return flightDatabase;
  }

  Future<bool> isIntializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}flights.db';
    return File(path).exists();
  }

  // Create database and table
  void _createFlightDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE flights(id INTEGER PRIMARY KEY AUTOINCREMENT, flightNo TEXT, reservedById TEXT, departureCity TEXT, arrivalCity TEXT, departureTime TEXT, arrivalTime TEXT, availableSeat INTEGER, price INTEGER)' );
  }

  // Insert operation
  Future<int> insertFlight(FlightModel flight) async {
    Database db = await getFlightDatabase;
    var result = await db.insert('flights', flight.toJson());
    return result;
  }

  // Fetch operation: Get all contacts
  Future<List<FlightModel>> getFlightList() async {
    Database db = await getFlightDatabase;
    var result = await db.query('flights');
    List<FlightModel> flightList = result.isNotEmpty
        ? result.map((flight) => FlightModel.fromJson(flight)).toList()
        : [];
    return flightList;
  }

  // Fetch operation: Get a Flight by id
  Future<FlightModel> getFlight(int id) async {
    var db = await getFlightDatabase;
    var result = await db.query('flights', where: 'id = ?', whereArgs: [id]);
    return FlightModel.fromJson(result.first);
  }

  // Update operation
  Future<int> updateFlight(FlightModel flightModel) async {
    var db = await getFlightDatabase;
    int result = await db.update('flights', flightModel.toJson(), where: 'id = ?', whereArgs: [flightModel.id]);
    return result;
  }

  // Delete operation
  Future<int> deleteFlight(int id) async {
    var db = await getFlightDatabase;
    int result = await db.delete('flights', where: 'id = ?', whereArgs: [id]);
    return result;
  }
}