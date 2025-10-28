class Reason {
	int? id;
	String? discription;
	dynamic extendedIndo;

	Reason({this.id, this.discription, this.extendedIndo});

	factory Reason.fromJson(Map<String, dynamic> json) => Reason(
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
