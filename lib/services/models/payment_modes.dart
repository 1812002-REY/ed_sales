class PaymentModes {
  int? id;
  String? discription;
  dynamic extendedIndo;

  PaymentModes({this.id, this.discription, this.extendedIndo});

  factory PaymentModes.fromJson(Map<String, dynamic> json) => PaymentModes(
    id: json['id'] as int?,
    discription: json['discription'] as String?,
    extendedIndo: json['extendedIndo'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'discription': discription,
    'extendedIndo': extendedIndo,
  };
}
