import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

import '../models/office.dart';
import '../officeservice.dart';

class OfficeController extends GetxController {
  final OfficeService officeService;

  OfficeController(this.officeService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var officeData = <Office>[].obs;

  Future<void> getOfficesData(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await officeService.getOffices(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        officeData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
