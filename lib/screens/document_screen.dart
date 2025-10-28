import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ed_sales/utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({
    super.key,
    required this.documentType,
    required this.imageDoc,
  });
  final DocumentType documentType;
  final String imageDoc;

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  Future<void> _shareImage(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/shared_image.jpg');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], text: 'Check out this image!');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.documentType == DocumentType.tinNumber
              ? 'TIN'
              : widget.documentType == DocumentType.paySlip
              ? 'Payslip'
              : widget.documentType == DocumentType.customerInfo
              ? 'Customer Form'
              : widget.documentType == DocumentType.businessLicence
              ? 'Business Licence'
              : widget.documentType == DocumentType.invoice
              ? 'Invoice'
              : '',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  child: Image.memory(
                    base64Decode(widget.imageDoc),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('Exit'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _shareImage(base64Decode(widget.imageDoc)),
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
