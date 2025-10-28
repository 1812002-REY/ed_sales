import 'package:ed_sales/services/models/doc_type.dart';
import 'package:ed_sales/services/repository/doc_type_service.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:get/get.dart';

class DocTypeController extends GetxController {
  final DocTypeService docTypeService;

  DocTypeController(this.docTypeService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var doc_type = <DocType>[].obs;

  Future<void> getdoc_typedata(String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await docTypeService.getDocType(token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        doc_type.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
