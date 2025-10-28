class Office {
  int? officeId;
  int? regionId;
  String? officeName;
  String? phone;
  String? address;
  String? region;
  int? active;

  Office({
    this.officeId,
    this.regionId,
    this.officeName,
    this.phone,
    this.address,
    this.region,
    this.active,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    officeId: json['officeID'] as int?,
    regionId: json['regionID'] as int?,
    officeName: json['officeName'] as String?,
    phone: json['phone'] as String?,
    address: json['address'] as String?,
    region: json['region'] as String?,
    active: json['active'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'officeID': officeId,
    'regionID': regionId,
    'officeName': officeName,
    'phone': phone,
    'address': address,
    'region': region,
    'active': active,
  };
}
