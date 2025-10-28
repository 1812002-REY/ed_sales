import 'package:ed_sales/services/models/efd_device.dart';
import 'package:ed_sales/services/repository/Efd_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class EfdController extends GetxController {
  final EfdService efdService;
  var filteredData = <EfdDevice>[].obs; // For search results

  @override
  void onInit() {
    super.onInit();
    filteredData.assignAll(efdData); // initially show all
  }

  void searchBySerial(String query) {
    if (query.isEmpty) {
      filteredData.assignAll(efdData);
    } else {
      final results = efdData.where(
        (item) => item.serialNumber.toString().toLowerCase().contains(
          query.toLowerCase(),
        ),
      );
      filteredData.assignAll(results);
    }
  }

  EfdController(this.efdService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var efdData = <EfdDevice>[].obs;

  Future<void> getEfdData(String token, int officeID) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await efdService.getEfd(token, officeID);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        efdData.value = result.data ?? [];
        filteredData.assignAll(efdData);
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
