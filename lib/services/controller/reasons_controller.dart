import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

import '../get_reasons_service.dart';
import '../models/reason.dart';

class ReasonsController extends GetxController {
  final ReasonsService reasonsService;

  ReasonsController(this.reasonsService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var reasonsData = <Reason>[].obs;

  Future<void> getReasonsData(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await reasonsService.getReasons(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        reasonsData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
