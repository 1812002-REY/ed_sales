class EfdDevice {
  int? deviceId;
  String? serialNumber;
  String? modelNumber;
  String? vendorName;
  int? operationStatus;
  int? paymentStatus;
  int? deviceStatus;
  DateTime? createDate;
  DateTime? dateUpdated;
  int? createdBy;
  int? updatedBy;
  int? office;
  dynamic uin;
  int? bundle;
  int? isReceived;
  int? clientId;
  dynamic tinNumber;
  dynamic invoiceNumber;
  int? region;
  dynamic paymentId;
  dynamic deviceType;

  EfdDevice({
    this.deviceId,
    this.serialNumber,
    this.modelNumber,
    this.vendorName,
    this.operationStatus,
    this.paymentStatus,
    this.deviceStatus,
    this.createDate,
    this.dateUpdated,
    this.createdBy,
    this.updatedBy,
    this.office,
    this.uin,
    this.bundle,
    this.isReceived,
    this.clientId,
    this.tinNumber,
    this.invoiceNumber,
    this.region,
    this.paymentId,
    this.deviceType,
  });

  factory EfdDevice.fromJson(Map<String, dynamic> json) => EfdDevice(
    deviceId: json['deviceID'] as int?,
    serialNumber: json['serialNumber'] as String?,
    modelNumber: json['modelNumber'] as String?,
    vendorName: json['vendorName'] as String?,
    operationStatus: json['operationStatus'] as int?,
    paymentStatus: json['paymentStatus'] as int?,
    deviceStatus: json['deviceStatus'] as int?,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    dateUpdated: json['dateUpdated'] == null
        ? null
        : DateTime.parse(json['dateUpdated'] as String),
    createdBy: json['createdBy'] as int?,
    updatedBy: json['updatedBy'] as int?,
    office: json['office'] as int?,
    uin: json['uin'] as dynamic,
    bundle: json['bundle'] as int?,
    isReceived: json['isReceived'] as int?,
    clientId: json['clientID'] as int?,
    tinNumber: json['tinNumber'] as dynamic,
    invoiceNumber: json['invoiceNumber'] as dynamic,
    region: json['region'] as int?,
    paymentId: json['paymentID'] as dynamic,
    deviceType: json['deviceType'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'deviceID': deviceId,
    'serialNumber': serialNumber,
    'modelNumber': modelNumber,
    'vendorName': vendorName,
    'operationStatus': operationStatus,
    'paymentStatus': paymentStatus,
    'deviceStatus': deviceStatus,
    'createDate': createDate?.toIso8601String(),
    'dateUpdated': dateUpdated?.toIso8601String(),
    'createdBy': createdBy,
    'updatedBy': updatedBy,
    'office': office,
    'uin': uin,
    'bundle': bundle,
    'isReceived': isReceived,
    'clientID': clientId,
    'tinNumber': tinNumber,
    'invoiceNumber': invoiceNumber,
    'region': region,
    'paymentID': paymentId,
    'deviceType': deviceType,
  };
}
