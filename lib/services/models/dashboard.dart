class Dashboard {
  int? deviceInStock;
  int? solDevices;
  int? notConfirmedDevices;
  int? transferedDevices;
  int? soldDeviceCurrent;

  Dashboard({
    this.deviceInStock,
    this.solDevices,
    this.notConfirmedDevices,
    this.transferedDevices,
    this.soldDeviceCurrent,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    deviceInStock: json['deviceInStock'] as int?,
    solDevices: json['solDevices'] as int?,
    notConfirmedDevices: json['notConfirmedDevices'] as int?,
    transferedDevices: json['transferedDevices'] as int?,
    soldDeviceCurrent: json['soldDeviceCurrent'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'deviceInStock': deviceInStock,
    'solDevices': solDevices,
    'notConfirmedDevices': notConfirmedDevices,
    'transferedDevices': transferedDevices,
    'soldDeviceCurrent': soldDeviceCurrent,
  };
}
