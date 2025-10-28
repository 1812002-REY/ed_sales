class Login {
  final String userName;
  final String password;

  Login({required this.userName, required this.password});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(userName: json['username'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {'username': userName, 'password': password};
}
