import 'dart:convert';

import 'package:ed_sales/services/models/client_dto.dart';
import 'package:ed_sales/services/models/register_client_response.dart';
import 'package:ed_sales/services/utils.dart';
import "package:http/http.dart" as http;

class RegisterClientService {
  Future<Resource<RegisterClientResponse>> registerClient(
    RegisterClient client,
    String token,
  ) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse('${AppUtils.baseUrl}/Client/AddClient'),
    );
    request.body = json.encode(client.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return Resource.success(
        RegisterClientResponse.fromJson(
          json.decode(await response.stream.bytesToString()),
        ),
      );
    } else {
      // print(response.reasonPhrase);
      return Resource.error('Failed to register client');
    }
  }
}
