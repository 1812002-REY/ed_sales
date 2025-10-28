import 'package:ed_sales/services/models/client_dto.dart';
import 'package:ed_sales/services/models/register_client_response.dart';
import 'package:ed_sales/services/register_client_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class RegisterClientController extends GetxController {
  final RegisterClientService registerClientService;

  RegisterClientController(this.registerClientService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var registerClientResponse = RegisterClientResponse().obs;
  Future<void> registerClient(String token, RegisterClient client) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await registerClientService.registerClient(client, token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        registerClientResponse.value = result.data ?? RegisterClientResponse();
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
