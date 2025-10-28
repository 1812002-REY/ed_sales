// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<devicebyId> welcomeFromJson(String str) =>
    List<devicebyId>.from(json.decode(str).map((x) => devicebyId.fromJson(x)));

String welcomeToJson(List<devicebyId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class devicebyId {
  int deviceId;
  String serialNumber;
  ModelNumber? modelNumber;
  VendorName? vendorName;
  int operationStatus;
  int paymentStatus;
  int deviceStatus;
  DateTime createDate;
  DateTime dateUpdated;
  int createdBy;
  int updatedBy;
  int office;
  String? uin;
  int bundle;
  int isReceived;
  int clientId;
  String? tinNumber;
  String? invoiceNumber;
  int region;
  int? paymentId;
  dynamic deviceType;

  devicebyId({
    required this.deviceId,
    required this.serialNumber,
    required this.modelNumber,
    required this.vendorName,
    required this.operationStatus,
    required this.paymentStatus,
    required this.deviceStatus,
    required this.createDate,
    required this.dateUpdated,
    required this.createdBy,
    required this.updatedBy,
    required this.office,
    required this.uin,
    required this.bundle,
    required this.isReceived,
    required this.clientId,
    required this.tinNumber,
    required this.invoiceNumber,
    required this.region,
    required this.paymentId,
    required this.deviceType,
  });

  factory devicebyId.fromJson(Map<String, dynamic> json) => devicebyId(
    deviceId: json["deviceID"],
    serialNumber: json["serialNumber"],
    modelNumber: modelNumberValues.map[json["modelNumber"]]!,
    vendorName: vendorNameValues.map[json["vendorName"]]!,
    operationStatus: json["operationStatus"],
    paymentStatus: json["paymentStatus"],
    deviceStatus: json["deviceStatus"],
    createDate: DateTime.parse(json["createDate"]),
    dateUpdated: DateTime.parse(json["dateUpdated"]),
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    office: json["office"],
    uin: json["uin"],
    bundle: json["bundle"],
    isReceived: json["isReceived"],
    clientId: json["clientID"],
    tinNumber: json["tinNumber"],
    invoiceNumber: json["invoiceNumber"],
    region: json["region"],
    paymentId: json["paymentID"],
    deviceType: json["deviceType"],
  );

  Map<String, dynamic> toJson() => {
    "deviceID": deviceId,
    "serialNumber": serialNumber,
    "modelNumber": modelNumberValues.reverse[modelNumber],
    "vendorName": vendorNameValues.reverse[vendorName],
    "operationStatus": operationStatus,
    "paymentStatus": paymentStatus,
    "deviceStatus": deviceStatus,
    "createDate": createDate.toIso8601String(),
    "dateUpdated": dateUpdated.toIso8601String(),
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "office": office,
    "uin": uin,
    "bundle": bundle,
    "isReceived": isReceived,
    "clientID": clientId,
    "tinNumber": tinNumber,
    "invoiceNumber": invoiceNumber,
    "region": region,
    "paymentID": paymentId,
    "deviceType": deviceType,
  };
}

enum ModelNumber { COMPAQ_M, EXPERT_SX, PERFECT_S }

final modelNumberValues = EnumValues({
  "compaq M": ModelNumber.COMPAQ_M,
  "Expert SX": ModelNumber.EXPERT_SX,
  "Perfect S": ModelNumber.PERFECT_S,
});

enum VendorName { DAISY }

final vendorNameValues = EnumValues({"DAISY": VendorName.DAISY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
