import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ed_sales/services/controller/login_controller.dart';
import 'package:ed_sales/services/controller/verified_paymentcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/repository/verified_paymentservice.dart';
import '../services/utils.dart';
import '../widgets/pdf_viewer.dart';

class InvoicePreviewScreen extends StatefulWidget {
  const InvoicePreviewScreen({super.key, required this.paymentID});
  final int paymentID;

  @override
  State<InvoicePreviewScreen> createState() => _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
  final loginController = Get.find<LoginController>();
  final verifiedPaymentController = Get.put(
    VerifiedPaymentController(VerifiedPaymentService()),
  );

  @override
  void initState() {
    super.initState();
    getVerifiedPaymentData();
  }

  getVerifiedPaymentData() {
    String token = loginController.loginData.single.accessToken ?? '';
    int paymentID = widget.paymentID;
    verifiedPaymentController.getVerifiedPaymentData(token, paymentID);
  }

  Future<void> _sharePdf(Uint8List pdfBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/shared_file.pdf');
    await file.writeAsBytes(pdfBytes);
    await Share.shareXFiles([XFile(file.path)], text: 'Check out this PDF!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
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
      body: Obx(() {
        if (verifiedPaymentController.isLoading.value) {
          return Center(child: AppUtils.getLoader);
        } else if (verifiedPaymentController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(verifiedPaymentController.errorMessage.value),
          );
        } else if (verifiedPaymentController.verifiedPaymentData.isEmpty) {
          return const Center(child: Text('No Verified Payment data found'));
        }
        final verifiedPayment =
            verifiedPaymentController.verifiedPaymentData.first;
        final base64String = verifiedPayment.ivoiceDetails ?? '';
        final cleanBase64 = base64String.split(',').last.trim();

        final pdfBytes = base64Decode(cleanBase64);

        return Column(
          children: [
            Expanded(child: Base64PdfViewer(base64String: cleanBase64)),
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
                    onPressed: () => _sharePdf(pdfBytes),
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
