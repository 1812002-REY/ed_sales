class RegisterClientResponse {
  String? status;
  int? code;
  String? message;
  dynamic data;
  String? createDate;
  dynamic receiptInfo;

  RegisterClientResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.createDate,
    this.receiptInfo,
  });

  factory RegisterClientResponse.fromJson(Map<String, dynamic> json) {
    return RegisterClientResponse(
      status: json['status'] as String?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] as dynamic,
      createDate: json['createDate'] as String?,
      receiptInfo: json['receiptInfo'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'data': data,
    'createDate': createDate,
    'receiptInfo': receiptInfo,
  };
}
