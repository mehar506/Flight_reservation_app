// ignore_for_file: public_member_api_docs, sort_constructors_first
class FlightModel {
  int id = -1;
  String flightNo = '';
  String reservedById = '';
  String departureCity = '';
  String arrivalCity = '';
  DateTime departureTime = DateTime.now();
  DateTime arrivalTime = DateTime.now();
  int availableSeat =0;
  int price = 0;
  
  FlightModel({
    required this.id,
    required this.flightNo,
    required this.reservedById,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.availableSeat,
    required this.price,
  });

  FlightModel.empty();

  FlightModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? -1;
    flightNo = json['flightNo'] ?? '';
    reservedById = json['reservedById'] ?? '';
    departureCity = json['departureCity'] ?? '';
    arrivalCity = json['arrivalCity'] ?? '';
    departureTime = DateTime.parse(json['departureTime'] ?? DateTime.now().toIso8601String());
    arrivalTime = DateTime.parse(json['arrivalTime'] ?? DateTime.now().toIso8601String());
    availableSeat = json['availableSeat'] ?? 0;
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'flightNo': flightNo,
    'reservedById': reservedById,
    'departureCity': departureCity,
    'arrivalCity': arrivalCity,
    'departureTime': departureTime.toIso8601String(),
    'arrivalTime': arrivalTime.toIso8601String(),
    'availableSeat': availableSeat,
    'price': price
  };

  @override
  String toString() {
    return 'FlightModel{id: $id, flightNo: $flightNo, reservedById: $reservedById, departureCity: $departureCity, arrivalCity: $arrivalCity, departureTime: $departureTime, arrivalTime: $arrivalTime, availableSeat: $availableSeat, price: $price}';
  }

}
