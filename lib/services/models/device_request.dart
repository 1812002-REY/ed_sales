// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<DeviceRequest> deviceRequestFromJson(String str) =>
    List<DeviceRequest>.from(
      json.decode(str).map((x) => DeviceRequest.fromJson(x)),
    );

String deviceRequestToJson(List<DeviceRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceRequest {
  int requestId;
  int requestedBy;
  int noOfDeviceRequested;
  DateTime dateRequested;
  int userCreated;
  int officeRequesting;
  int approvedBy;
  int updatedBy;
  DateTime dateModified;
  int noOfDeviceApproved;
  int isApproved;
  dynamic rejectReason;

  DeviceRequest({
    required this.requestId,
    required this.requestedBy,
    required this.noOfDeviceRequested,
    required this.dateRequested,
    required this.userCreated,
    required this.officeRequesting,
    required this.approvedBy,
    required this.updatedBy,
    required this.dateModified,
    required this.noOfDeviceApproved,
    required this.isApproved,
    required this.rejectReason,
  });

  factory DeviceRequest.fromJson(Map<String, dynamic> json) => DeviceRequest(
    requestId: json["requestID"],
    requestedBy: json["requestedBy"],
    noOfDeviceRequested: json["noOfDeviceRequested"],
    dateRequested: DateTime.parse(json["dateRequested"]),
    userCreated: json["userCreated"],
    officeRequesting: json["officeRequesting"],
    approvedBy: json["approvedBy"],
    updatedBy: json["updatedBy"],
    dateModified: DateTime.parse(json["dateModified"]),
    noOfDeviceApproved: json["noOfDeviceApproved"],
    isApproved: json["isApproved"],
    rejectReason: json["rejectReason"],
  );

  Map<String, dynamic> toJson() => {
    "requestID": requestId,
    "requestedBy": requestedBy,
    "noOfDeviceRequested": noOfDeviceRequested,
    "dateRequested": dateRequested.toIso8601String(),
    "userCreated": userCreated,
    "officeRequesting": officeRequesting,
    "approvedBy": approvedBy,
    "updatedBy": updatedBy,
    "dateModified": dateModified.toIso8601String(),
    "noOfDeviceApproved": noOfDeviceApproved,
    "isApproved": isApproved,
    "rejectReason": rejectReason,
  };
}
