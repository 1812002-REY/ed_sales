class VfdDevice {
  String? deviceId;
  String? clientName;
  int? operationStatus;
  int? paymentStatus;
  dynamic deviceStatus;
  String? createDate;
  String? dateUpdated;
  int? createdBy;
  int? updatedBy;
  int? office;
  String? certKey;
  int? clientId;
  String? tinNumber;
  dynamic invoiceNumber;
  int? region;
  int? paymentId;
  dynamic certificateName;
  dynamic certificatePassword;
  dynamic cerficateDocument;

  VfdDevice({
    this.deviceId,
    this.clientName,
    this.operationStatus,
    this.paymentStatus,
    this.deviceStatus,
    this.createDate,
    this.dateUpdated,
    this.createdBy,
    this.updatedBy,
    this.office,
    this.certKey,
    this.clientId,
    this.tinNumber,
    this.invoiceNumber,
    this.region,
    this.paymentId,
    this.certificateName,
    this.certificatePassword,
    this.cerficateDocument,
  });

  factory VfdDevice.fromJson(Map<String, dynamic> json) => VfdDevice(
    deviceId: json['deviceID'] as String?,
    clientName: json['clientName'] as String?,
    operationStatus: json['operationStatus'] as int?,
    paymentStatus: json['paymentStatus'] as int?,
    deviceStatus: json['deviceStatus'] as dynamic,
    createDate: json['createDate'] as String?,
    dateUpdated: json['dateUpdated'] as String?,
    createdBy: json['createdBy'] as int?,
    updatedBy: json['updatedBy'] as int?,
    office: json['office'] as int?,
    certKey: json['certKey'] as String?,
    clientId: json['clientID'] as int?,
    tinNumber: json['tinNumber'] as String?,
    invoiceNumber: json['invoiceNumber'] as dynamic,
    region: json['region'] as int?,
    paymentId: json['paymentID'] as int?,
    certificateName: json['certificateName'] as dynamic,
    certificatePassword: json['certificatePassword'] as dynamic,
    cerficateDocument: json['cerficateDocument'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'deviceID': deviceId,
    'clientName': clientName,
    'operationStatus': operationStatus,
    'paymentStatus': paymentStatus,
    'deviceStatus': deviceStatus,
    'createDate': createDate,
    'dateUpdated': dateUpdated,
    'createdBy': createdBy,
    'updatedBy': updatedBy,
    'office': office,
    'certKey': certKey,
    'clientID': clientId,
    'tinNumber': tinNumber,
    'invoiceNumber': invoiceNumber,
    'region': region,
    'paymentID': paymentId,
    'certificateName': certificateName,
    'certificatePassword': certificatePassword,
    'cerficateDocument': cerficateDocument,
  };
}
