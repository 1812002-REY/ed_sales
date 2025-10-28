import 'dart:convert';

import 'package:ed_sales/services/models/verified_payment.dart'
    show VerifiedPayment;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class VerifiedPaymentService {
  /// Fetch a single verified payment by ID
  Future<Resource<List<VerifiedPayment>>> getVerifiedPayment(
    String token,
    paymentID,
  ) async {
    // final response = await http.get(Uri.parse('$baseUrl/DeviceRequest/GetRequestByID?RequestID=$id'));
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'text/plain',
    };
    var request = http.Request(
      'GET',
      Uri.parse(
        '${AppUtils.baseUrl}/Payment/GetVerifiedPaymentListByID?paymentID=$paymentID',
      ),
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
        jsonData.map((item) => VerifiedPayment.fromJson(item)).toList(),
      );
    } else {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response status: ${response.reasonPhrase}');
      return Resource.error('Failed to load verified payment');
    }
  }
}
