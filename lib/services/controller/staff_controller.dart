import 'package:ed_sales/services/models/s_taffs.dart';
import 'package:ed_sales/services/staff_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
  final StaffService staffService;

  StaffController(this.staffService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var staffData = <STaffs>[].obs;

  Future<void> getStaffData(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await staffService.getStaff(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        staffData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
