import 'package:ed_sales/services/models/verified_payment.dart'
    show VerifiedPayment;
import 'package:ed_sales/services/repository/verified_paymentservice.dart'
    show VerifiedPaymentService;
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class VerifiedPaymentController extends GetxController {
  final VerifiedPaymentService verifiedPaymentService;

  VerifiedPaymentController(this.verifiedPaymentService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var verifiedPaymentData = <VerifiedPayment>[].obs;

  Future<void> getVerifiedPaymentData(String token, int paymentID) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await verifiedPaymentService.getVerifiedPayment(
        token,
        paymentID,
      );

      switch (result.status) {
        case Status.success:
          verifiedPaymentData.value = result.data ?? [];
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
