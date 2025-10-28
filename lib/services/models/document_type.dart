class DocumentType {
  int? id;
  String? discription;
  dynamic extendedIndo;

  DocumentType({this.id, this.discription, this.extendedIndo});

  factory DocumentType.fromJson(Map<String, dynamic> json) => DocumentType(
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
