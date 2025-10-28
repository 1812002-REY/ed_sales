import 'package:ed_sales/services/models/client_id.dart';
import 'package:ed_sales/services/repository/Client_id.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  final ClientService clientService;

  ClientController(this.clientService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var clientData = <ClientId>[].obs;

  Future<void> getClientData(String token, int clientId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      clientData.clear();

      final result = await clientService.getClient(token, clientId);
      print('CLIENT RESULT: ${result.data}');
      print('CLIENT STATUS: ${result.status}');

      if (result.status == Status.success) {
        if (result.data is List) {
          clientData.value = (result.data as List).cast<ClientId>();
        } else if (result.data is ClientId) {
          clientData.value = [result.data as ClientId];
        }
      } else {
        errorMessage.value = result.message ?? "Something went wrong";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
//   Future<void> getClientData(String token, int clientId) async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     final result = await clientService.getClient(token, clientId);

//     isLoading.value = false;

//     switch (result.status) {
//       case Status.loading:
//         isLoading.value = true;
//         break;
//       case Status.success:
//         clientData.value = (result.data as List?)?.cast<ClientId>() ?? [];
//         break;
//       case Status.error:
//         errorMessage.value = result.message ?? "Something went wrong";
//         break;
//     }
//   }
// }
