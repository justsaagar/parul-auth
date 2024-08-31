import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? dateOfBirth;
  String? gender;

  UserModel({this.userId, this.firstName, this.lastName, this.emailAddress, this.dateOfBirth, this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
      };
}
