// To parse this JSON data, do
//
//     final matchPreferenceModel = matchPreferenceModelFromJson(jsonString);

import 'dart:convert';

MatchPreferenceModel matchPreferenceModelFromJson(String str) =>
    MatchPreferenceModel.fromJson(json.decode(str));

String matchPreferenceModelToJson(MatchPreferenceModel data) =>
    json.encode(data.toJson());

class MatchPreferenceModel {
  final bool? status;
  final Message? message;
  final Data? data;

  MatchPreferenceModel({
    this.status,
    this.message,
    this.data,
  });

  factory MatchPreferenceModel.fromJson(Map<String, dynamic> json) =>
      MatchPreferenceModel(
        status: json["status"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  final List<User>? users;

  Data({
    this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final int? height;
  final int? religion;
  final String? imageUrl;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.height,
    this.religion,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        height: (json["height"] is int)
            ? json["height"]
            : int.tryParse(json["height"]?.toString() ?? ''),
        religion: json["religion"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "height": height,
        "religion": religion,
        "image_url": imageUrl,
      };
}

class Message {
  final List<String>? success;

  Message({
    this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"] == null
            ? []
            : List<String>.from(json["success"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success":
            success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
      };
}
