class Clients {
  int? clientId;
  String? clientName;
  String? tinNumber;
  String? address;
  String? phone;
  String? email;
  int? region;
  dynamic docAttachment;
  dynamic documentType;
  dynamic docTinNumber;
  dynamic docBusinessLicense;
  dynamic docCustomerInfoform;
  dynamic docCustomerId;
  int? createdBy;
  DateTime? createDate;
  dynamic modifiedBy;
  dynamic modifiedDate;
  String? salesPerson;
  dynamic licenseExpiryDate;
  dynamic licenseRemainTime;
  dynamic licenseIsActive;
  bool? hasEfdSupport;

  Clients({
    this.clientId,
    this.clientName,
    this.tinNumber,
    this.address,
    this.phone,
    this.email,
    this.region,
    this.docAttachment,
    this.documentType,
    this.docTinNumber,
    this.docBusinessLicense,
    this.docCustomerInfoform,
    this.docCustomerId,
    this.createdBy,
    this.createDate,
    this.modifiedBy,
    this.modifiedDate,
    this.salesPerson,
    this.licenseExpiryDate,
    this.licenseRemainTime,
    this.licenseIsActive,
    this.hasEfdSupport,
  });

  factory Clients.fromJson(Map<String, dynamic> json) => Clients(
    clientId: json['clientID'] as int?,
    clientName: json['clientName'] as String?,
    tinNumber: json['tinNumber'] as String?,
    address: json['address'] as String?,
    phone: json['phone'] as String?,
    email: json['email'] as String?,
    region: json['region'] as int?,
    docAttachment: json['docAttachment'] as dynamic,
    documentType: json['documentType'] as dynamic,
    docTinNumber: json['docTinNumber'] as dynamic,
    docBusinessLicense: json['docBusinessLicense'] as dynamic,
    docCustomerInfoform: json['docCustomerInfoform'] as dynamic,
    docCustomerId: json['docCustomerID'] as dynamic,
    createdBy: json['createdBy'] as int?,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    modifiedBy: json['modifiedBy'] as dynamic,
    modifiedDate: json['modifiedDate'] as dynamic,
    salesPerson: json['salesPerson'] as String?,
    licenseExpiryDate: json['licenseExpiryDate'] as dynamic,
    licenseRemainTime: json['licenseRemainTime'] as dynamic,
    licenseIsActive: json['licenseIsActive'] as dynamic,
    hasEfdSupport: json['hasEFDSupport'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'clientID': clientId,
    'clientName': clientName,
    'tinNumber': tinNumber,
    'address': address,
    'phone': phone,
    'email': email,
    'region': region,
    'docAttachment': docAttachment,
    'documentType': documentType,
    'docTinNumber': docTinNumber,
    'docBusinessLicense': docBusinessLicense,
    'docCustomerInfoform': docCustomerInfoform,
    'docCustomerID': docCustomerId,
    'createdBy': createdBy,
    'createDate': createDate?.toIso8601String(),
    'modifiedBy': modifiedBy,
    'modifiedDate': modifiedDate,
    'salesPerson': salesPerson,
    'licenseExpiryDate': licenseExpiryDate,
    'licenseRemainTime': licenseRemainTime,
    'licenseIsActive': licenseIsActive,
    'hasEFDSupport': hasEfdSupport,
  };
}
