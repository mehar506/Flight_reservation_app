// ignore_for_file: public_member_api_docs, sort_constructors_first
class PassengerModel {
  int id = -1;
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String password = '';

  PassengerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  PassengerModel.empty();

  PassengerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    password = json['password'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'password': password,
      };
}
