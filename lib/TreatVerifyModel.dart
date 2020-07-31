import 'dart:convert';

TreatVerify treatVerifyFromJson(String str) =>
    TreatVerify.fromJson(json.decode(str));

String treatVerifyToJson(TreatVerify data) => json.encode(data.toJson());

class TreatVerify {
  TreatVerify({
    this.details,
    this.status,
  });

  String details;
  int status;

  factory TreatVerify.fromJson(Map<String, dynamic> json) => TreatVerify(
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "status": status,
      };
}
