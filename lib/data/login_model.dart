// To parse this JSON data, do
//
//     final loginusermodel = loginusermodelFromJson(jsonString);

import 'dart:convert';

Loginusermodel loginusermodelFromJson(String str) =>
    Loginusermodel.fromJson(json.decode(str));

String loginusermodelToJson(Loginusermodel data) => json.encode(data.toJson());

class Loginusermodel {
  final Data data;
  final String message;

  Loginusermodel({
    required this.data,
    required this.message,
  });

  factory Loginusermodel.fromJson(Map<String, dynamic> json) => Loginusermodel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  final String email;
  final bool isVerified;
  final String access;
  final String refresh;

  Data({
    required this.email,
    required this.isVerified,
    required this.access,
    required this.refresh,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        isVerified: json["is_verified"],
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "is_verified": isVerified,
        "access": access,
        "refresh": refresh,
      };
}
