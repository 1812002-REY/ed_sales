import 'package:ed_sales/services/models/payment_modes.dart';
import 'package:ed_sales/services/repository/payment_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final PaymentModesService paymentModesService;

  PaymentController(this.paymentModesService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var payments = <PaymentModes>[].obs;

  Future<void> getAllPayments(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await paymentModesService.getAllPayments(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        payments.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
