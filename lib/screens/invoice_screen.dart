
import 'package:ed_sales/screens/device_screen.dart';
import 'package:ed_sales/screens/invoice_preview_screen.dart';
import 'package:ed_sales/services/controller/Client_controller.dart'
    show ClientController;
import 'package:ed_sales/services/controller/login_controller.dart';
import 'package:ed_sales/services/models/efd_device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../services/repository/Client_id.dart';
import '../services/utils.dart';
import '../utils.dart';
import '../widgets/sale_vfd_bar.dart';
import 'document_screen.dart';

class InvoiceScreen extends StatefulWidget {
  final bool fromEFD;
  final EfdDevice efdDevice;
  final String? clientID;

  const InvoiceScreen({
    super.key,
    this.fromEFD = false,
    required this.efdDevice,
    this.clientID,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final loginController = Get.find<LoginController>();
  final clientController = Get.put(ClientController(ClientService()));
  @override
  void initState() {
    super.initState();
    getClientData();
  }

  getClientData() async {
    debugPrint("Client comes from efd: ${widget.efdDevice.clientId}");

    String token = loginController.loginData.single.accessToken ?? '';
    int clientId = widget.efdDevice.clientId ?? 0;

    await clientController.getClientData(token, clientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Invoice',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),

          onPressed: () {
            // Go back to EFD page
            // Navigator.pushNamed(context, '/efd');
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => DeviceScreen()),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
             iconColor: Colors.white,
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
      body: ListView(
        children: [
          // Green header with invoice number
          // InvoiceTopBar(efdDevice: widget.efdDevice),
          SaleTopBar(title: widget.efdDevice.serialNumber.toString()),

          // Dark background content
          Obx(() {
            if (clientController.isLoading.value) {
              return Center(child: AppUtils.getLoader);
            } else if (clientController.errorMessage.isNotEmpty) {
              return Center(child: Text(clientController.errorMessage.value));
            } else if (clientController.clientData.isEmpty) {
              return const Center(child: Text('No client data found'));
            }
            final client = clientController.clientData.first;
            debugPrint('Client Data: $client');
            return Container(
              color: awesomeGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Client Details ----
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Client Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    client.clientName ?? 'Unknown Client',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text(
                                  //   'NDUMBARO',
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                  Text(
                                    client.address ?? 'No Address',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              client.phone ?? 'No Phone Number',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ---- More Detail ----
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'More Detail',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tin Number row
                  _detailRow(
                    'Tin Number',
                    client.tinNumber ?? 'N/A',
                    true,
                    client.docTinNumber ?? '',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(color: Colors.white, thickness: 1),
                  ),
                  // Invoice Number row
                  _detailRow(
                    'Invoice Number',
                    '${widget.efdDevice.invoiceNumber ?? 'N/A'}',
                    false,
                    client.docCustomerId ?? '',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(color: Colors.white, thickness: 1),
                  ),
                  const SizedBox(height: 30),

                  // View buttons row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            (() async {
                              try {
                                await Get.to(
                                  () => DocumentScreen(
                                    documentType: DocumentType.businessLicence,
                                    imageDoc: client.docBusinessLicense ?? '',
                                  ),
                                );
                              } catch (err, stack) {
                                debugPrint(
                                  'Error opening DocumentScreen: $err\n$stack',
                                );
                                Get.snackbar(
                                  'Error',
                                  'Could not open document',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            })();
                          },
                          child: _twoLineBlueText('View Business', 'Licence'),
                        ),
                        GestureDetector(
                          onTap: () {
                            (() async {
                              try {
                                await Get.to(
                                  () => DocumentScreen(
                                    documentType: DocumentType.customerInfo,
                                    imageDoc: client.docCustomerInfoform ?? '',
                                  ),
                                );
                              } catch (err, stack) {
                                debugPrint(
                                  'Error opening DocumentScreen: $err\n$stack',
                                );
                                Get.snackbar(
                                  'Error',
                                  'Could not open document',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            })();
                          },
                          child: _twoLineBlueText(
                            'View Customer',
                            'Information',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Attachments
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _attachColumn('Delivery Note'),
                        _attachColumn('Job Completion Form'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Complete button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey, // blue like view buttons
                          borderRadius: BorderRadius.circular(
                            25,
                          ), // rounded like register
                        ),
                        child: TextButton(
                          onPressed: () {
                            // TODO: complete logic here
                            print('Complete button pressed');
                          },
                          child: const Text(
                            'Complete',
                            style: TextStyle(
                              color: Colors.white, // white text like register
                              fontSize: 16, // same as register
                              fontWeight: FontWeight.bold, // same as register
                              letterSpacing: 1.1, // same as register
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Helper widgets for cleaner code
  Widget _detailRow(String title, String value, bool isTin, String imgSrc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              (() async {
                try {
                  final docType = isTin
                      ? DocumentType.tinNumber
                      : DocumentType.invoice;
                  await Get.to(
                    () => isTin
                        ? DocumentScreen(
                            documentType: docType,
                            imageDoc: imgSrc,
                          )
                        : InvoicePreviewScreen(
                            paymentID: int.parse(
                              widget.efdDevice.paymentId.toString(),
                            ),
                          ),
                  );
                } catch (err, stack) {
                  debugPrint('Error opening DocumentScreen: $err\n$stack');
                  Get.snackbar(
                    'Error',
                    'Could not open document',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              })();
            },
            child: const Text(
              'View',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _twoLineBlueText extends StatelessWidget {
  final String line1, line2;
  const _twoLineBlueText(this.line1, this.line2);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          line1,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          line2,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _attachColumn extends StatelessWidget {
  final String title;
  const _attachColumn(this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImage(context),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text(
                'Attachment here',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              SizedBox(width: 8),
              Icon(Icons.upload, color: Colors.blueGrey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
