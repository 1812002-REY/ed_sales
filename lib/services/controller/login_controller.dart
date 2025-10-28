import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/login_response/login_response.dart';
import '../repository/login_service.dart';
import '../utils.dart';

class LoginController extends GetxController {
  final LoginService service;

  LoginController(this.service);

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final _showPassword = false.obs;
  bool get showPassword => _showPassword.value;
  void togglePasswordVisibility() {
    _showPassword.value = !_showPassword.value;
    debugPrint('Password visibility: $_showPassword');
  }

  var loginData = <LoginResponse>[].obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await service.login(username, password);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        loginData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
