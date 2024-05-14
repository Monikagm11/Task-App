// To parse this JSON data, do
//
//     final registerusermodel = registerusermodelFromJson(jsonString);

import 'dart:convert';

Registerusermodel registerusermodelFromJson(String str) =>
    Registerusermodel.fromJson(json.decode(str));

String registerusermodelToJson(Registerusermodel data) =>
    json.encode(data.toJson());

class Registerusermodel {
  final Data data;
  final String message;

  Registerusermodel({
    required this.data,
    required this.message,
  });

  factory Registerusermodel.fromJson(Map<String, dynamic> json) =>
      Registerusermodel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final int phone;
  final String address;

  Data({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "address": address,
      };
}
