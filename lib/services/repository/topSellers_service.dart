import 'dart:convert';
import 'package:ed_sales/services/models/top_sellers.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopsellersService {
  /// Fetch a single device request by ID
  Future<Resource<List<TopSellers>>> getTopSellers(String token) async {
    // final response = await http.get(Uri.parse('$baseUrl/DeviceRequest/GetRequestByID?RequestID=$id'));
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'text/plain',
    };
    var request = http.Request(
      'GET',
      Uri.parse('${AppUtils.baseUrl}/Dashboard/GetTopSellers'),
    );
    request.headers.addAll(headers);
    debugPrint('Request URL: ${request.url}');
    http.StreamedResponse response = await request.send();
    debugPrint('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(
        await response.stream.bytesToString(),
      );
      return Resource.success(
        jsonData.map((item) => TopSellers.fromJson(item)).toList(),
      );
    } else {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response status: ${response.reasonPhrase}');
      return Resource.error('Failed to load top sellers');
    }
  }
}
