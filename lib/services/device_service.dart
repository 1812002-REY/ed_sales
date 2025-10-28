import 'dart:convert';
import 'package:ed_sales/services/utils.dart';
import 'package:http/http.dart' as http;

import 'models/efd_device.dart';
// <-- adjust the path to your model file

class DeviceService {
  /// Fetch **all devices** as a List<devicebyId>
  Future<List<EfdDevice>> fetchAllDevices() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIzNDZlOGJjYy1hNjJjLTQzZTEtYmRjZS1iN2Q1MjAxNjA5ZWIiLCJzdWIiOiJzYWxlc0Bzb2Z0bmV0LmNvLnR6IiwiVXNlcklkIjoiNTciLCJSb2xlIjoiNSIsIkNsaWVudCI6IjAiLCJPcmlnaW5hdG9ySVAiOiIxOTYuNDEuODYuMjAiLCJQbGF0Zm9ybSI6IjEiLCJuYmYiOjE3NTg4MTE1MDIsImV4cCI6MTc1ODgxNTEwMiwiaWF0IjoxNzU4ODExNTAyLCJpc3MiOiJodHRwczovL3NvZnRlZmQuc29mdG5ldC5jby50eiIsImF1ZCI6Imh0dHBzOi8vY2xpZW50cy5zb2Z0bmV0LmNvLnR6In0.dTSBAVTQcqpIizfUrR__gfvMaLBjAKygXjbEwzjDl5k',
      'Content-Type': 'text/plain',
    };
    var request = http.Request(
      'GET',
      Uri.parse(
        '${AppUtils.baseUrl}/EFDDevice/GetDeviceListByOffice?officeID=19',
      ),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      // Parse the response and return a list of devicebyId
      final List<dynamic> jsonList = json.decode(responseBody);
      return jsonList.map((json) => EfdDevice.fromJson(json)).toList();
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to fetch devices: ${response.reasonPhrase}');
    }
  }
}
