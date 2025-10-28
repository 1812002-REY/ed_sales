import 'package:ed_sales/services/models/requestby_id.dart' show RequestbyId;
import 'package:ed_sales/services/repository/requestbyidservice.dart'
    show RequestbyIdService;
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class Requestbyidcontroller extends GetxController {
  final RequestbyIdService requestbyidService;

  Requestbyidcontroller(this.requestbyidService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var requestbyidData = <RequestbyId>[].obs;

  Future<void> getRequestbyidData(String token, int requestid) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await requestbyidService.getRequestbyid(token, requestid);

      switch (result.status) {
        case Status.success:
          requestbyidData.value = result.data ?? [];
          break;
        case Status.error:
          errorMessage.value = result.message ?? "Something went wrong";
          break;
        default:
          break;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
