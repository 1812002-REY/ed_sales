// import/ <-- where notificationState & userDateFormat live

class NotificationOffice {
  final String createDate;
  final String deviceSerialNumber;
  final int operationStatus;
  final String notificationState;
  final String formattedDate;

  NotificationOffice({
    required this.createDate,
    required this.operationStatus,
    required this.notificationState,
    required this.formattedDate,
    required this.deviceSerialNumber,
  });
}
