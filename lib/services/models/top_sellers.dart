class TopSellers {
  String? fullName;
  int? deviceSold;
  String? officeName;

  TopSellers({this.fullName, this.deviceSold, this.officeName});

  factory TopSellers.fromJson(Map<String, dynamic> json) => TopSellers(
    fullName: json['fullName'] as String?,
    deviceSold: json['deviceSold'] as int?,
    officeName: json['officeName'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'deviceSold': deviceSold,
    'officeName': officeName,
  };
}
