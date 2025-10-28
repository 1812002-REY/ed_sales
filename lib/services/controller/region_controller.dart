import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

import '../models/regions.dart';
import '../region_service.dart';

class RegionController extends GetxController {
  final RegionService regionService;

  RegionController(this.regionService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var regionData = <Region>[].obs;

  Future<void> getRegionData(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await regionService.getRegion(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        regionData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
