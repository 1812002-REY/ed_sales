import 'dart:convert';

import 'package:ed_sales/services/models/login_response/login_response.dart';
import 'package:ed_sales/services/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

/// Resource class to mimic Kotlin Resource

class LoginService {
  Future<Resource<List<LoginResponse>>> login(
    String username,
    String password,
  ) async {
    const encryptedEndpoint =
        "u+jxKXcYrpjtWB5WcWrVe5Ts3iiKl0rRYr4RiTf+AVo0KrioUpn8SXetjGm7RHPc";
    final decryptedEndpoint = AppUtils.decrypt(encryptedEndpoint);
    final decryptedBaseUrl = AppUtils.decrypt(AppUtils.encryptedBaseUrl);

    try {
      final loginRequest = Login(userName: username, password: password);
      debugPrint(
        'Requesting URL: $decryptedBaseUrl$decryptedEndpoint with body: ${loginRequest.toJson()}',
      );
      // final response = await http.post(
      //   Uri.parse('$decryptedBaseUrl$decryptedEndpoint'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(loginRequest.toJson()),
      // );
      String url = "$decryptedBaseUrl$decryptedEndpoint";
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(loginRequest.toJson());
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        final List<dynamic> body = jsonDecode(data);
        if (body.isEmpty) {
          return Resource.error("Wrong username or password");
        }
        final logins = body
            .map((e) => LoginResponse.fromJson(e as Map<String, dynamic>))
            .toList();
        return Resource.success(logins);
      } else {
        return Resource.error("Service not available, please try again later");
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return Resource.error("Something went wrong, please try again later");
    }
  }
}
