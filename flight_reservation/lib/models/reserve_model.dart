// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReserveModel {
  int id = -1;
  int passengerID = -1;
  int flightID = -1;
  String date = '';
  String seat = '';
  String price = '';
  ReserveModel({
    required this.id,
    required this.passengerID,
    required this.flightID,
    required this.date,
    required this.seat,
    required this.price,
  });
  
  ReserveModel.empty();

  ReserveModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? -1;
    passengerID = json['passengerID'] ?? -1;
    flightID = json['flightID'] ?? -1;
    date = json['date'] ?? '';
    seat = json['seatNumber'] ?? '';
    price = json['price'] ?? '';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'passengerID': passengerID,
    'flightID': flightID,
    'date': date,
    'seatNumber': seat,
    'price': price
  };
  
}
