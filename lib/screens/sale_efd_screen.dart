import 'package:dropdown_search/dropdown_search.dart';
import 'package:ed_sales/constants.dart';
import 'package:ed_sales/services/models/efd_device.dart';
import 'package:ed_sales/utils.dart';
import 'package:ed_sales/widgets/custom_button.dart';
import 'package:ed_sales/widgets/sale_efd_bar.dart' show SaleEfdTopBar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller/Efd_controller.dart';
import '../services/controller/clients_controller.dart';
import '../services/controller/login_controller.dart';
import '../services/controller/payment_controller.dart';
import '../services/repository/Efd_service.dart';
import '../services/repository/clients_service.dart';
import '../services/repository/payment_service.dart';
import '../services/utils.dart' show AppUtils;
import 'register_screen.dart';
import 'softnet_login_page.dart';

class SaleEFDPage extends StatefulWidget {
  final EfdDevice efdDevice;
  const SaleEFDPage({super.key, required this.efdDevice});

  @override
  State<SaleEFDPage> createState() => _SaleEFDPageState();
}

class _SaleEFDPageState extends State<SaleEFDPage> {
  final loginController = Get.find<LoginController>();
  final EfdController efdController = Get.put(EfdController(EfdService()));
  final ClientsController clientsController = Get.put(
    ClientsController(ClientsService()),
  );
  final PaymentController paymentController = Get.put(
    PaymentController(PaymentModesService()),
  );

  String? selectedClient;
  String? selectedPaymentMode;
  TextEditingController amountController = TextEditingController();
  String attachmentText = 'Attachment here';
  bool isVfd = false;

  @override
  void initState() {
    super.initState();
    final token = loginController.loginData.single.accessToken ?? '';
    final officeID = loginController.loginData.single.officeId ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      efdController.getEfdData(token, officeID);
      clientsController.getAllClients(token);
      paymentController.getAllPayments(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Device',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: const Text("Logout"),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SoftNetLoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SaleEfdTopBar(serialNumber: widget.efdDevice.serialNumber.toString()),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ===== EFD Header =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _switchButton(
                      "EFD",
                      !isVfd,
                      () => setState(() => isVfd = false),
                    ),
                    _switchButton("VFD", isVfd, () {
                      // setState(() => isVfd = true);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => SaleVFDPage()),
                      // );
                    }),
                  ],
                ),
                const SizedBox(height: 25),

                // ===== Choose Client =====
                _sectionTitle("Choose Client"),
                const SizedBox(height: 10),
                _buildSelectClient(),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "If new register here →",
                      style: TextStyle(color: Colors.blue[200], fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // ===== Payment =====
                _sectionTitle("Payment Detail"),
                const SizedBox(height: 10),
                _buildSelectPaymentMode(),
                const SizedBox(height: 15),

                // ===== Amount =====
                _amountField(amountController),
                const SizedBox(height: 25),

                // ===== Attachment =====
                // _sectionTitle("Upload Attachment"),
                // const SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () => pickImage(context),
                //   child: _buildBox(attachmentText, withUpload: true),
                // ),
                // ===== Upload Attachment Section =====
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    Text(
                      "Upload Attachment",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Attachment box with icon
                    GestureDetector(
                      onTap: () => pickImage(context),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: awesomeGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Expanded ensures full text fits and no apostrophe appears
                            Expanded(
                              child: Text(
                                attachmentText, // "Attachment here"
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // safe if screen ndogo
                              ),
                            ),

                            // Upload icon
                            const Icon(
                              Icons.file_upload_outlined,
                              color: Colors.blueGrey,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),

                // ===== Submit =====
                _submitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section title
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Client Dropdown (Searchable)
  Widget _buildSelectClient() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: awesomeGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        if (clientsController.isLoading.value) {
          return Center(child: AppUtils.getLoader);
        } else if (clientsController.errorMessage.isNotEmpty) {
          return Center(child: Text(clientsController.errorMessage.value));
        }
        final clients = clientsController.clients;

        return DropdownSearch<String>(
          items: (filter, loadProps) =>
              clients.map((client) => client.clientName ?? '').toList(),
          selectedItem: selectedClient != 'Select Client'
              ? selectedClient
              : null,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "Select Client",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search client...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              selectedClient = value;
            });
          },
        );
      }),
    );
  }

  // Payment Dropdown
  Widget _buildSelectPaymentMode() {
    return Obx(() {
      if (paymentController.isLoading.value) {
        return Center(child: AppUtils.getLoader);
      } else if (paymentController.errorMessage.isNotEmpty) {
        return Center(child: Text(paymentController.errorMessage.value));
      }

      final payments = paymentController.payments;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: awesomeGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          value: selectedPaymentMode,
          hint: const Text(
            'Select Payment Mode',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          isExpanded: true,
          dropdownColor: Colors.blueGrey,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey),
          underline: const SizedBox(),
          onChanged: (value) => setState(() => selectedPaymentMode = value),
          items: payments
              .map(
                (p) => DropdownMenuItem(
                  value: p.id.toString(),
                  child: Text(p.discription ?? 'Unknown'),
                ),
              )
              .toList(),
        ),
      );
    });
  }

  // Amount Field
  Widget _amountField(TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: awesomeGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          hintText: 'Enter Amount',
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  // Custom Input Container
  Widget _buildBox(
    String text, {
    bool withArrow = false,
    bool withUpload = false,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: awesomeGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          if (withArrow)
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.lightBlue,
                size: 24,
              ),
            ),
          if (withUpload)
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.file_upload_outlined,
                color: Colors.blueGrey,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }

  // Submit Button
  Widget _submitButton() {
    return CustomButton(
      onPressed: _handleSubmit,
      title: const Text(
        'SUBMIT',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
    // return Container(
    //   width: double.infinity,
    //   height: 50,
    //   decoration: BoxDecoration(
    //     color: Colors.blueGrey,
    //     borderRadius: BorderRadius.circular(25),
    //   ),
    //   child: TextButton(
    //     onPressed: _handleSubmit,
    //     child: const Text(
    //       'SUBMIT',
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 16,
    //         fontWeight: FontWeight.bold,
    //         letterSpacing: 1.1,
    //       ),
    //     ),
    //   ),
    // );
  }

  void _handleSubmit() {
    print("Form Submitted ✅");
  }

  Widget _switchButton(String label, bool active, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active ? Colors.blueGrey : Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: Size(
          MediaQuery.of(context).size.width / 2 - 24,
          MediaQuery.of(context).size.height * 0.045,
        ),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
