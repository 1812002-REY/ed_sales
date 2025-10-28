import 'package:ed_sales/services/models/clients.dart';
import 'package:ed_sales/services/repository/clients_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class ClientsController extends GetxController {
  final ClientsService clientService;

  ClientsController(this.clientService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var clients = <Clients>[].obs;

  Future<void> getAllClients(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await clientService.getAllClients(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        clients.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
