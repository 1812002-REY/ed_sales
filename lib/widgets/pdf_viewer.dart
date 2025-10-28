import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Base64PdfViewer extends StatelessWidget {
  final String base64String;
  const Base64PdfViewer({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    // Clean string
    final cleanBase64 = base64String.split(',').last.trim();
    final Uint8List pdfBytes = base64Decode(cleanBase64);

    return SfPdfViewer.memory(pdfBytes);
  }
}
