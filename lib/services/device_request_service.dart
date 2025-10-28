import 'dart:convert';
import 'package:ed_sales/services/models/device_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class EFDService {
  /// Fetch a single device request by ID
  Future<List<DeviceRequest>> getRequestById(int id) async {
    // final response = await http.get(Uri.parse('$baseUrl/DeviceRequest/GetRequestByID?RequestID=$id'));
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI4YWVkOWM0Ni1hOWJmLTRkNTktYWI2Yy0yNzgyN2RkMzgzZmQiLCJzdWIiOiJzYWxlc0Bzb2Z0bmV0LmNvLnR6IiwiVXNlcklkIjoiNTciLCJSb2xlIjoiNSIsIkNsaWVudCI6IjAiLCJPcmlnaW5hdG9ySVAiOiIxOTYuNDEuODYuMjAiLCJQbGF0Zm9ybSI6IjEiLCJuYmYiOjE3NTg4MDM2MzcsImV4cCI6MTc1ODgwNzIzNywiaWF0IjoxNzU4ODAzNjM3LCJpc3MiOiJodHRwczovL3NvZnRlZmQuc29mdG5ldC5jby50eiIsImF1ZCI6Imh0dHBzOi8vY2xpZW50cy5zb2Z0bmV0LmNvLnR6In0.017Na3Wd3hVFCBW2pynIDFDD1NxiHvjvXtXJK1xZIqM',
      'Content-Type': 'text/plain',
    };
    var request = http.Request(
      'GET',
      Uri.parse(
        '${AppUtils.baseUrl}/DeviceRequest/GetRequestByID?RequestID=$id',
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
      return jsonData.map((item) => DeviceRequest.fromJson(item)).toList();
    } else {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response status: ${response.reasonPhrase}');
      throw Exception('Failed to load device request');
    }
  }
}
