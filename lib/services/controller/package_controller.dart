import 'package:ed_sales/services/models/packages.dart';
import 'package:ed_sales/services/repository/package_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class PackageController extends GetxController {
  final PackageService packageService;

  PackageController(this.packageService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var package = <Packages>[].obs;

  Future<void> getAllPackages(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await packageService.getAllPackages(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        package.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
