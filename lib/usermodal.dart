import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.phone,
    this.detail,
  });

  int status;
  int phone;
  String detail;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        detail: json["detail"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "detail": detail,
        "phone": phone,
      };
}
