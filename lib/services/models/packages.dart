class Packages {
  int? id;
  String? packageName;
  double? packagePrice;
  int? packageTime;
  int? quantity;
  int? noOfUsers;
  int? maxReceipt;
  int? maxBranch;
  int? packageType;
  int? containPos;

  Packages({
    this.id,
    this.packageName,
    this.packagePrice,
    this.packageTime,
    this.quantity,
    this.noOfUsers,
    this.maxReceipt,
    this.maxBranch,
    this.packageType,
    this.containPos,
  });

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    id: json['id'] as int?,
    packageName: json['packageName'] as String?,
    packagePrice: json['packagePrice'] as double?,
    packageTime: json['packageTime'] as int?,
    quantity: json['quantity'] as int?,
    noOfUsers: json['noOfUsers'] as int?,
    maxReceipt: json['maxReceipt'] as int?,
    maxBranch: json['maxBranch'] as int?,
    packageType: json['packageType'] as int?,
    containPos: json['containPOS'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'packageName': packageName,
    'packagePrice': packagePrice,
    'packageTime': packageTime,
    'quantity': quantity,
    'noOfUsers': noOfUsers,
    'maxReceipt': maxReceipt,
    'maxBranch': maxBranch,
    'packageType': packageType,
    'containPOS': containPos,
  };
}
