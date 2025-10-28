class RequestbyId {
  int? requestId;
  int? requestedBy;
  int? noOfDeviceRequested;
  DateTime? dateRequested;
  int? userCreated;
  int? officeRequesting;
  int? approvedBy;
  int? updatedBy;
  DateTime? dateModified;
  int? noOfDeviceApproved;
  int? isApproved;
  dynamic rejectReason;

  RequestbyId({
    this.requestId,
    this.requestedBy,
    this.noOfDeviceRequested,
    this.dateRequested,
    this.userCreated,
    this.officeRequesting,
    this.approvedBy,
    this.updatedBy,
    this.dateModified,
    this.noOfDeviceApproved,
    this.isApproved,
    this.rejectReason,
  });

  factory RequestbyId.fromJson(Map<String, dynamic> json) => RequestbyId(
    requestId: json['requestID'] as int?,
    requestedBy: json['requestedBy'] as int?,
    noOfDeviceRequested: json['noOfDeviceRequested'] as int?,
    dateRequested: json['dateRequested'] == null
        ? null
        : DateTime.parse(json['dateRequested'] as String),
    userCreated: json['userCreated'] as int?,
    officeRequesting: json['officeRequesting'] as int?,
    approvedBy: json['approvedBy'] as int?,
    updatedBy: json['updatedBy'] as int?,
    dateModified: json['dateModified'] == null
        ? null
        : DateTime.parse(json['dateModified'] as String),
    noOfDeviceApproved: json['noOfDeviceApproved'] as int?,
    isApproved: json['isApproved'] as int?,
    rejectReason: json['rejectReason'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'requestID': requestId,
    'requestedBy': requestedBy,
    'noOfDeviceRequested': noOfDeviceRequested,
    'dateRequested': dateRequested?.toIso8601String(),
    'userCreated': userCreated,
    'officeRequesting': officeRequesting,
    'approvedBy': approvedBy,
    'updatedBy': updatedBy,
    'dateModified': dateModified?.toIso8601String(),
    'noOfDeviceApproved': noOfDeviceApproved,
    'isApproved': isApproved,
    'rejectReason': rejectReason,
  };
}
