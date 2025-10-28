import 'package:ed_sales/services/models/vfd_device.dart';
import 'package:ed_sales/services/repository/vfd_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class VfdController extends GetxController {
  final VfdService vfdService;
  var filteredData = <VfdDevice>[].obs; // For search results

  @override
  void onInit() {
    super.onInit();
    filteredData.assignAll(vfdData); // initially show all
  }

  VfdController(this.vfdService);

  void searchBySerial(String query) {
    if (query.isEmpty) {
      filteredData.assignAll(vfdData);
    } else {
      final results = vfdData.where(
        (item) => item.deviceId.toString().toLowerCase().contains(
          query.toLowerCase(),
        ),
      );
      filteredData.assignAll(results);
    }
  }

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var vfdData = <VfdDevice>[].obs;

  Future<void> getVfdData(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await vfdService.getvfd(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        vfdData.value = result.data ?? [];
        filteredData.assignAll(vfdData);
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
