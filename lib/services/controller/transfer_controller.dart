import 'package:get/get.dart';

class TransferController extends GetxController {
  var transferId = ''.obs;
  var quantity = ''.obs;
  var selectedOffice = ''.obs;
  var selectedStaff = ''.obs;
  var selectedReason = ''.obs;
  var serialNumber = ''.obs;
  var savedDevices = <String>[].obs;

  var isLoading = false.obs;
  var showOptionDialog = false.obs;
  var showInputDialog = false.obs;
  var showSavedDevicesDialog = false.obs;

  void selectOffice(String office) => selectedOffice.value = office;
  void selectStaff(String staff) => selectedStaff.value = staff;
  void selectReason(String reason) => selectedReason.value = reason;

  void openOptionDialog() => showOptionDialog.value = true;
  void closeOptionDialog() => showOptionDialog.value = false;
  void openInputDialog() => showInputDialog.value = true;
  void closeInputDialog() => showInputDialog.value = false;


}