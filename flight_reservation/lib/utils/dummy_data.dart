
import 'package:flight_reservation/models/flight_model.dart';

class DummyData {
 
  static List<FlightModel> flights = [
    FlightModel(
      id: 0,
      flightNo: 'PK-123',
      reservedById: '',
      departureCity: 'Karachi',
      arrivalCity: 'Lahore',
      departureTime: DateTime.now().add(const Duration(days: 1)),
      arrivalTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      availableSeat: 100,
      price: 15000,
    ),
    FlightModel(
      id: 1,
      flightNo: 'PK-456',
      reservedById: '',
      departureCity: 'Lahore',
      arrivalCity: 'Islamabad',
      departureTime: DateTime.now().add(const Duration(days: 2)),
      arrivalTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
      availableSeat: 100,
      price: 20000,
    ),
    FlightModel(
      id: 2,
      flightNo: 'PK-789',
      reservedById: '',
      departureCity: 'Islamabad',
      arrivalCity: 'Karachi',
      departureTime: DateTime.now().add(const Duration(days: 3)),
      arrivalTime: DateTime.now().add(const Duration(days: 3, hours: 2)),
      availableSeat: 100,
      price: 25000,
    ),
    FlightModel(
      id: 3,
      flightNo: 'PK-101',
      reservedById: '',
      departureCity: 'Karachi',
      arrivalCity: 'Islamabad',
      departureTime: DateTime.now().add(const Duration(days: 4)),
      arrivalTime: DateTime.now().add(const Duration(days: 4, hours: 2)),
      availableSeat: 100,
      price: 30000,
    ),
  ];
}
