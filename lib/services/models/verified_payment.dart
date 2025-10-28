class VerifiedPayment {
  int? paymentId;
  int? efdid;
  int? operationStatus;
  int? paymentMethod;
  int? amount;
  int? paymentStatus;
  DateTime? paymentDate;
  DateTime? lastUpdated;
  int? receivedBy;
  int? lastUpdatedBy;
  int? cliendId;
  String? clientName;
  String? clientPhone;
  String? taxRegion;
  int? office;
  String? document;
  dynamic receipt;
  String? serialNumber;
  String? uin;
  dynamic rejectReason;
  String? ivoiceNumber;
  String? ivoiceDetails;
  dynamic deliveryNote;
  dynamic jobCompletion;
  String? tinNumber;
  dynamic packageId;
  dynamic licenseNumber;
  dynamic packageName;
  dynamic packagePrice;
  int? deviceType;

  VerifiedPayment({
    this.paymentId,
    this.efdid,
    this.operationStatus,
    this.paymentMethod,
    this.amount,
    this.paymentStatus,
    this.paymentDate,
    this.lastUpdated,
    this.receivedBy,
    this.lastUpdatedBy,
    this.cliendId,
    this.clientName,
    this.clientPhone,
    this.taxRegion,
    this.office,
    this.document,
    this.receipt,
    this.serialNumber,
    this.uin,
    this.rejectReason,
    this.ivoiceNumber,
    this.ivoiceDetails,
    this.deliveryNote,
    this.jobCompletion,
    this.tinNumber,
    this.packageId,
    this.licenseNumber,
    this.packageName,
    this.packagePrice,
    this.deviceType,
  });

  factory VerifiedPayment.fromJson(Map<String, dynamic> json) {
    return VerifiedPayment(
      paymentId: json['paymentID'] as int?,
      efdid: json['efdid'] as int?,
      operationStatus: json['operationStatus'] as int?,
      paymentMethod: json['paymentMethod'] as int?,
      amount: json['amount'] as int?,
      paymentStatus: json['paymentStatus'] as int?,
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      receivedBy: json['receivedBy'] as int?,
      lastUpdatedBy: json['lastUpdatedBy'] as int?,
      cliendId: json['cliendID'] as int?,
      clientName: json['clientName'] as String?,
      clientPhone: json['clientPhone'] as String?,
      taxRegion: json['taxRegion'] as String?,
      office: json['office'] as int?,
      document: json['document'] as String?,
      receipt: json['receipt'] as dynamic,
      serialNumber: json['serialNumber'] as String?,
      uin: json['uin'] as String?,
      rejectReason: json['rejectReason'] as dynamic,
      ivoiceNumber: json['ivoiceNumber'] as String?,
      ivoiceDetails: json['ivoiceDetails'] as String?,
      deliveryNote: json['deliveryNote'] as dynamic,
      jobCompletion: json['jobCompletion'] as dynamic,
      tinNumber: json['tinNumber'] as String?,
      packageId: json['packageID'] as dynamic,
      licenseNumber: json['licenseNumber'] as dynamic,
      packageName: json['packageName'] as dynamic,
      packagePrice: json['packagePrice'] as dynamic,
      deviceType: json['deviceType'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'paymentID': paymentId,
    'efdid': efdid,
    'operationStatus': operationStatus,
    'paymentMethod': paymentMethod,
    'amount': amount,
    'paymentStatus': paymentStatus,
    'paymentDate': paymentDate?.toIso8601String(),
    'lastUpdated': lastUpdated?.toIso8601String(),
    'receivedBy': receivedBy,
    'lastUpdatedBy': lastUpdatedBy,
    'cliendID': cliendId,
    'clientName': clientName,
    'clientPhone': clientPhone,
    'taxRegion': taxRegion,
    'office': office,
    'document': document,
    'receipt': receipt,
    'serialNumber': serialNumber,
    'uin': uin,
    'rejectReason': rejectReason,
    'ivoiceNumber': ivoiceNumber,
    'ivoiceDetails': ivoiceDetails,
    'deliveryNote': deliveryNote,
    'jobCompletion': jobCompletion,
    'tinNumber': tinNumber,
    'packageID': packageId,
    'licenseNumber': licenseNumber,
    'packageName': packageName,
    'packagePrice': packagePrice,
    'deviceType': deviceType,
  };
}
