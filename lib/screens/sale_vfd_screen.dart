import 'package:dropdown_search/dropdown_search.dart'
    show DropdownSearch, PopupProps, TextFieldProps, DropDownDecoratorProps;
import 'package:ed_sales/constants.dart' show awesomeGrey;
import 'package:ed_sales/services/controller/clients_controller.dart';
import 'package:ed_sales/services/controller/package_controller.dart';
import 'package:ed_sales/services/controller/payment_controller.dart';
import 'package:ed_sales/services/repository/clients_service.dart';
import 'package:ed_sales/services/repository/package_service.dart';
import 'package:ed_sales/services/repository/payment_service.dart';
import 'package:ed_sales/widgets/custom_button.dart';
import 'package:ed_sales/widgets/sale_vfd_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller/login_controller.dart';
import '../services/utils.dart';
import '../utils.dart';
import 'register_screen.dart';

class SaleVFDPage extends StatefulWidget {
  const SaleVFDPage({super.key});

  @override
  _SaleVFDPageState createState() => _SaleVFDPageState();
}

class _SaleVFDPageState extends State<SaleVFDPage> {
  final ClientsController clientsController = Get.put(
    ClientsController(ClientsService()),
  );
  final PaymentController paymentController = Get.put(
    PaymentController(PaymentModesService()),
  );
  final PackageController packageController = Get.put(
    PackageController((PackageService())),
  );
  final loginController = Get.find<LoginController>();
  String? selectedPaymentMode;
  String? selectedPackage;
  String selectedClient = 'Select Client';
  TextEditingController amountController = TextEditingController();
  String attachmentText = 'Attachment here';
  @override
  void initState() {
    super.initState();
    getClientData();
    getPaymentData();
    getPackageData();
  }

  getClientData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    clientsController.getAllClients(token);
  }

  getPaymentData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    paymentController.getAllPayments(token);
  }

  getPackageData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    packageController.getAllPackages(token);
  }

  Widget _buildSelectPaymentMode() {
    return Obx(() {
      if (paymentController.isLoading.value) {
        return Center(child: AppUtils.getLoader);
      } else if (paymentController.errorMessage.isNotEmpty) {
        return Center(child: Text(paymentController.errorMessage.value));
      }
      final payments = paymentController.payments;
      debugPrint('payment Data: $payments');

      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: awesomeGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
      alignment: AlignmentDirectional.centerStart, // 👈 text upande wa kushoto
            hint: const Text(
              'Select Payment Mode',
              style: TextStyle(color: Colors.black),
            ),
            value: selectedPaymentMode,
            isExpanded: true,

            borderRadius: BorderRadius.circular(10),
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.blueGrey,
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            underline: Container(height: 0),
            menuMaxHeight: 200,
            onChanged: (String? newValue) {
              setState(() {
                selectedPaymentMode = newValue!;
              });
            },
            items: payments.map<DropdownMenuItem<String>>((payment) {
              return DropdownMenuItem<String>(
                value: payment.id.toString(), // use ID or name
                child: Text(
                  payment.discription ?? "Unknown",
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildSelectPackage() {
    return Obx(() {
      if (packageController.isLoading.value) {
        return Center(child: AppUtils.getLoader);
      } else if (packageController.errorMessage.isNotEmpty) {
        return Center(child: Text(packageController.errorMessage.value));
      }
      final package = packageController.package;
      debugPrint('package Data: $package');

      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),

        decoration: BoxDecoration(
          color: awesomeGrey,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
      alignment: AlignmentDirectional.centerStart, 
            hint: const Text(
              'Select Package',
              style: TextStyle(color: Colors.black),
            ),
            value: selectedPackage,
            isExpanded: true,

            borderRadius: BorderRadius.circular(10),
            // padding: EdgeInsets.all(5),
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.blueGrey,
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            underline: Container(height: 0),
            onChanged: (String? newValue) {
              setState(() {
                selectedPackage = newValue!;
              });
            },
            menuMaxHeight: 300,
            items: package.map<DropdownMenuItem<String>>((pkg) {
              final value =
                  "${pkg.packageName ?? "Unknown"} - ${pkg.packagePrice?.toString() ?? "0"}";
              return DropdownMenuItem<String>(
                value: value, // this is the unique value
                child: Text(value, style: const TextStyle(fontSize: 12)),
              );
            }).toList(),
            //       style: const TextStyle(fontSize: 12),
            //     );
            //   );
            // }).toList(),
          ),
        ),
      );
    });
  }

  // void _showClientSelectionDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Select Client', style: TextStyle(fontSize: 10)),
  //         content: SizedBox(
  //           // 👈 constrain dialog height
  //           width: double.maxFinite,
  //           height: 300, // set max height for the dialog
  //           child: Column(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8),
  //                   color: const Color.fromARGB(255, 246, 240, 240),
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: TextField(
  //                     decoration: InputDecoration(
  //                       hintText: 'Search',
  //                       border: InputBorder.none,
  //                       prefixIcon: Icon(Icons.search),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 8),
  //               Expanded(
  //                 // now works inside the SizedBox
  //                 child: ListView(
  //                   children: clients.map((client) {
  //                     return ListTile(
  //                       title: Text(
  //                         client,
  //                         style: const TextStyle(fontSize: 12),
  //                       ),
  //                       onTap: () {
  //                         setState(() {
  //                           selectedClient = client;
  //                         });
  //                         Navigator.of(context).pop();
  //                       },
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildSelectClient() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: awesomeGrey,
      ),
      child: Obx(() {
        if (clientsController.isLoading.value) {
          return Center(child: AppUtils.getLoader);
        } else if (clientsController.errorMessage.isNotEmpty) {
          return Center(child: Text(clientsController.errorMessage.value));
        }
        final clients = clientsController.clients;
        debugPrint('Client Data: $clients');

        return DropdownSearch<String>(
          items: (filter, loadProps) => clients
              .map((client) => client.clientName.toString())
              .toList(), // your list of clients
          selectedItem: selectedClient != 'Select Client'
              ? selectedClient
              : null,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "Select Client", // fixed hint
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
              selectedClient = value.toString();
            });
          },
        );
      }),
    );
  }

  // List<String> clients = [
  //   'CROPSCHAIN COMPANY LTD',
  //   'PRIVA LAURENT KIMARIO',
  //   'REMMY BATHOLOMEW MACHAGE',
  //   'SHOMASA.CO.LIMITED',
  //   'ZUHURA WAZIRI SHABANI',
  //   'THOMAS JOSEPH KISEMA',
  //   'TANDI INTERNATIONAL COMPANY LIMITED',
  //   'UMOJA WA WAUZA MCHELE MASHINENI',
  //   'LUCY JOHN MATOLI',
  //   'KALOMBO EDWARD KASSANGA',
  //   'AMOS WILSON CHARICHA',
  // ];

  // List<String> packages = [
  //   'BASIC - 100,000 TZS',
  //   'STANDARD - 200,000 TZS',
  //   'PREMIUM - 300,000 TZS',
  //   'ENTERPRISE - 500,000 TZS',
  //   'ULTIMATE - 1,000,000 TZS',
  //   'CUSTOM - Contact Us',
  //   'TRIAL - 0 TZS',
  //   'ECONOMY - 50,000 TZS',
  //   'BUSINESS - 150,000 TZS',
  //   'CORPORATE - 400,000 TZS',
  //   'STARTUP - 75,000 TZS',
  //   'PROFESSIONAL - 250,000 TZS',
  //   'ADVANCED - 350,000 TZS',
  //   'DELUXE - 600,000 TZS',
  //   'SUPREME - 1,500,000 TZS',
  // ];
  // List<String> paymentModes = [
  //   'HQ',
  //   'Bank Transfer',
  //   'Mobile Money',
  //   'Cash',
  //   'Cheque',
  //   'PayPal',
  //   'Stripe',
  //   'Square',
  //   'Cryptocurrency',
  //   'Direct Debit',
  //   'EFT',
  //   'Western Union',
  //   'MoneyGram',
  //   'Alipay',
  //   'WeChat Pay',
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Device',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ======= Header =======
          SaleTopBar(title: 'Sales VFD'),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: awesomeGrey, width: 1),
                    ),
                    child: const Center(
                      child: Text(
                        'EFD',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey,
                    ),
                    child: const Center(
                      child: Text(
                        'VFD',
                        style: TextStyle(
                       color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ======= Form Section =======
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Choose Client"),

                const SizedBox(height: 10),
                _buildSelectClient(),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle navigation to register screen
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
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
                _sectionTitle("Choose Package"),
                const SizedBox(height: 10),
                //_buildBox(selectedPackage, withArrow: true),
                _buildSelectPackage(),
                const SizedBox(height: 25),
                _sectionTitle("Payment Detail"),
                const SizedBox(height: 10),
                _buildSelectPaymentMode(),
                const SizedBox(height: 15),
                _amountField(amountController),

                const SizedBox(height: 25),
                _sectionTitle("Upload attachment"),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => pickImage(context),
                  child: _buildBox(attachmentText, withUpload: true),
                ),

                const SizedBox(height: 30),
                _submitButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable section title
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
              color: Colors.white,
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
      style: const TextStyle(color: Colors.white),
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
