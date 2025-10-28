class DocType {
  int? id;
  String? discription;
  dynamic extendedIndo;

  DocType({this.id, this.discription, this.extendedIndo});

  factory DocType.fromJson(Map<String, dynamic> json) => DocType(
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
