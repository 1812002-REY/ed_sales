class LoginResponse {
  dynamic clientId;
  int? staffId;
  int? roleId;
  String? firstName;
  String? lastName;
  String? userName;
  String? phone;
  String? email;
  int? officeId;
  dynamic password;
  dynamic newPassword;
  int? active;
  String? accessToken;
  String? refreshToken;

  LoginResponse({
    this.clientId,
    this.staffId,
    this.roleId,
    this.firstName,
    this.lastName,
    this.userName,
    this.phone,
    this.email,
    this.officeId,
    this.password,
    this.newPassword,
    this.active,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    clientId: json['clientID'] as dynamic,
    staffId: json['staffID'] as int?,
    roleId: json['roleID'] as int?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    userName: json['userName'] as String?,
    phone: json['phone'] as String?,
    email: json['email'] as String?,
    officeId: json['officeID'] as int?,
    password: json['password'] as dynamic,
    newPassword: json['newPassword'] as dynamic,
    active: json['active'] as int?,
    accessToken: json['accessToken'] as String?,
    refreshToken: json['refreshToken'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'clientID': clientId,
    'staffID': staffId,
    'roleID': roleId,
    'firstName': firstName,
    'lastName': lastName,
    'userName': userName,
    'phone': phone,
    'email': email,
    'officeID': officeId,
    'password': password,
    'newPassword': newPassword,
    'active': active,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };
}
