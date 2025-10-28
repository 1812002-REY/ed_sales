class RegisterClient {
  String? address;
  int? clientID;
  String? clientName;
  String? createDate;
  int? createdBy;
  String? docAttachment;
  String? docBusinessLicense;
  String? docCustomerID;
  String? docCustomerInfoform;
  String? docTinNumber;
  int? documentType;
  String? email;
  int? modifiedBy;
  String? modifiedDate;
  String? phone;
  int? region;
  String? salesPerson;
  String? tinNumber;

  RegisterClient({
    this.address,
    this.clientID,
    this.clientName,
    this.createDate,
    this.createdBy,
    this.docAttachment,
    this.docBusinessLicense,
    this.docCustomerID,
    this.docCustomerInfoform,
    this.docTinNumber,
    this.documentType,
    this.email,
    this.modifiedBy,
    this.modifiedDate,
    this.phone,
    this.region,
    this.salesPerson,
    this.tinNumber,
  });

  toJson() => {
    'address': address,
    'client_id': clientID,
    'client_name': clientName,
    'create_date': createDate,
    'created_by': createdBy,
    'doc_attachment': docAttachment,
    'doc_business_license': docBusinessLicense,
    'doc_customer_id': docCustomerID,
    'doc_customer_infoform': docCustomerInfoform,
    'doc_tin_number': docTinNumber,
    'document_type': documentType,
    'email': email,
    'modified_by': modifiedBy,
    'modified_date': modifiedDate,
    'phone': phone,
    'region': region,
    'sales_person': salesPerson,
    'tin_number': tinNumber,
  };

  fromJson(Map<String, dynamic> json) => RegisterClient(
    address: json['address'] as String?,
    clientID: json['client_id'] as int?,
    clientName: json['client_name'] as String?,
    createDate: json['create_date'] as String?,
    createdBy: json['created_by'] as int?,
    docAttachment: json['doc_attachment'] as String?,
    docBusinessLicense: json['doc_business_license'] as String?,
    docCustomerID: json['doc_customer_id'] as String?,
    docCustomerInfoform: json['doc_customer_infoform'] as String?,
    docTinNumber: json['doc_tin_number'] as String?,
    documentType: json['document_type'] as int?,
    email: json['email'] as String?,
    modifiedBy: json['modified_by'] as int?,
    modifiedDate: json['modified_date'] as String?,
    phone: json['phone'] as String?,
    region: json['region'] as int?,
    salesPerson: json['sales_person'] as String?,
    tinNumber: json['tin_number'] as String?,
  );
}
