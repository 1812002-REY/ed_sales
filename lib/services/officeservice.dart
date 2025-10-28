import 'dart:convert';
import 'package:ed_sales/services/models/office.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class OfficeService {
  /// Fetch a single device request by ID
  Future<Resource<List<Office>>> getOffices(String token) async {
    // final response = await http.get(Uri.parse('$baseUrl/DeviceRequest/GetRequestByID?RequestID=$id'));
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'text/plain',
    };
    var request = http.Request(
      'GET',
      Uri.parse('${AppUtils.baseUrl}/Office/GetOfficeList'),
    );
    request.headers.addAll(headers);
    debugPrint('Request URL: ${request.url}');
    http.StreamedResponse response = await request.send();
    debugPrint('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(
        await response.stream.bytesToString(),
      );
      return Resource.success(jsonData.map((item) => Office.fromJson(item)).toList());
    } else {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response status: ${response.reasonPhrase}');
      return Resource.error('Failed to load office');
    }
  }
}
