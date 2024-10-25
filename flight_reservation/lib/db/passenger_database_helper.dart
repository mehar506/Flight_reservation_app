import 'dart:io';

import 'package:flight_reservation/models/passenger_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PassengerDatabaseHelper {
  static PassengerDatabaseHelper? databaseHelper; // Singleton DatabaseHelper
  static Database? database; // Singleton Database

  PassengerDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory PassengerDatabaseHelper() {
    databaseHelper ??= PassengerDatabaseHelper._createInstance();
    return databaseHelper!;
  }
  
  // Define database name and version
  Future<Database> get getPassengerDatabase async {
    database ??= await initializePassengerDatabase();
    return database!;
  }

  // Initialize database
  Future<Database> initializePassengerDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}passenger.db';
    var passengerDatabase =
        await openDatabase(path, version: 1, onCreate: _createPassengerDb);
    return passengerDatabase;
  }

  // Create database and table
  void _createPassengerDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE passengers(id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, lastName TEXT, email TEXT, phone TEXT, password TEXT)');
  }

  // Insert operation
  Future<int> insertPassenger(PassengerModel passenger) async {
    Database db = await getPassengerDatabase;
    var result = await db.insert('passengers', passenger.toJson());
    return result;
  }

  // Fetch operation: Get all passenger objects from database
  Future<List<PassengerModel>> getPassengerList() async {
    var db = await getPassengerDatabase;
    var result = await db.query('passengers');
    List<PassengerModel> passengerList = result.isNotEmpty
        ? result.map((passenger) => PassengerModel.fromJson(passenger)).toList()
        : [];
    return passengerList;
  }

  Future<PassengerModel> getPassenger(String email, String password) async{
    PassengerModel passengerModel = PassengerModel.empty();
    var db = await getPassengerDatabase;
    var result = await db.query('passengers', where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if(result.isNotEmpty){
      passengerModel = PassengerModel.fromJson(result.first);
    }
    return passengerModel;
  }

  // Update operation
  Future<int> updatePassenger(PassengerModel passengerModel) async {
    var db = await getPassengerDatabase;
    int result = await db.update('passengers', passengerModel.toJson(),
        where: 'id = ?', whereArgs: [passengerModel.id]);
    return result;
  }

  // Delete operation
  Future<int> deletePassenger(int id) async {
    var db = await getPassengerDatabase;
    int result = await db.delete('passengers', where: 'id = ?', whereArgs: [id]);
    return result;
  }
}