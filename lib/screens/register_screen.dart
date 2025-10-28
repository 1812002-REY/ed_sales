import 'package:ed_sales/constants.dart' as color show awesomeGrey, blueGrey;
import 'package:ed_sales/constants.dart';
import 'package:ed_sales/services/controller/Doc_type_controller.dart';
import 'package:ed_sales/services/controller/login_controller.dart';
import 'package:ed_sales/services/controller/register_client_controller.dart';
import 'package:ed_sales/services/models/doc_type.dart';
import 'package:ed_sales/services/region_service.dart';
import 'package:ed_sales/services/register_client_service.dart';
import 'package:ed_sales/services/repository/doc_type_service.dart';
import 'package:ed_sales/services/utils.dart' show AppUtils;
import 'package:ed_sales/utils.dart';
import 'package:ed_sales/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller/region_controller.dart' show RegionController;
import '../services/models/client_dto.dart';
import '../services/models/regions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRegion;
  String? _selectedDocType;
  final loginController = Get.find<LoginController>();
  final regionController = Get.put(RegionController(RegionService()));
  final docTypeController = Get.put(DocTypeController(DocTypeService()));
  final registerClientController = Get.put(
    RegisterClientController(RegisterClientService()),
  );

  @override
  void initState() {
    super.initState();
    getRegionData();
    getdocTypeData();
  }

  getRegionData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      regionController.getRegionData(token);
    });
  }

  getdocTypeData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      docTypeController.getdoc_typedata(token);
    });
  }

  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final tinController = TextEditingController();
  final emailController = TextEditingController();
  final salesPersonController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final regionFieldController = TextEditingController();
  final docTypeFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Register Client', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (BuildContext context) {
              return [PopupMenuItem(value: 3, child: Text("Logout"))];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Client Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: firstNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "First Name",
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: color.awesomeGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: addressController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Address",
                    fillColor: color.awesomeGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Phone",
                    fillColor: color.awesomeGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: tinController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "TIN",
                    fillColor: color.awesomeGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Email",
                    fillColor: color.awesomeGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: salesPersonController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Sales Person",
                    fillColor: color.awesomeGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),

                // --- Region Dropdown ---
                Obx(() {
                  if (regionController.isLoading.value) {
                    return Center(child: AppUtils.getLoader);
                  } else if (regionController.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(regionController.errorMessage.value),
                    );
                  }
                  final regions = regionController.regionData;

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: color.awesomeGrey,
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        "select region",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: _selectedRegion,
                      items: regions
                          .map(
                            (region) => DropdownMenuItem(
                              value: region.discription.toString(),
                              child: Text(region.discription),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedRegion = value);
                        regionFieldController.text = value ?? '';
                      },
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // --- Document Type Dropdown ---
                Obx(() {
                  if (docTypeController.isLoading.value) {
                    return Center(child: AppUtils.getLoader);
                  } else if (docTypeController.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(docTypeController.errorMessage.value),
                    );
                  } else if (docTypeController.doc_type.isEmpty) {
                    return const Center(child: Text('No doc type found'));
                  }
                  final docTypes = docTypeController.doc_type;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: color.awesomeGrey,
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        "select doc type",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: _selectedDocType,
                      items: docTypes
                          .map(
                            (doc) => DropdownMenuItem(
                              value: doc.discription,
                              child: Text(doc.discription.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedDocType = value);
                        docTypeFieldController.text = value ?? '';
                      },
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // --- Attachments VFD style ---
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => pickImage(context),
                      child: _buildBox("Attach TIN Number", withUpload: true),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => pickImage(context),
                      child: _buildBox(
                        "Attach Customer Form",
                        withUpload: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => pickImage(context),
                      child: _buildBox("Business License", withUpload: true),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => pickImage(context),
                      child: _buildBox("Attach Customer ID", withUpload: true),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- Register Button ---
                CustomButton(
                  onPressed: () async {
                    // Handle registration logic

                    int regionId = regionController.regionData
                        .firstWhere(
                          (region) => region.discription == _selectedRegion,
                          orElse: () =>
                              Region(id: 0, discription: '', extendedIndo: ''),
                        )
                        .id;
                    int docTypeId =
                        docTypeController.doc_type
                            .firstWhere(
                              (doc) => doc.discription == _selectedDocType,
                              orElse: () => DocType(id: 0, discription: ''),
                            )
                            .id ??
                        0;
                    RegisterClient newClient = RegisterClient(
                      address: addressController.text,
                      clientName: firstNameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      tinNumber: tinController.text,
                      salesPerson: salesPersonController.text,
                      region: regionId,
                      documentType: docTypeId,
                      clientID: 0,
                      createDate: DateTime.now().toIso8601String(),
                      createdBy: loginController.loginData.single.clientId,
                      docAttachment: "",
                      docBusinessLicense: "",
                      docCustomerID: "",
                      docCustomerInfoform: "",
                      docTinNumber: "",
                      modifiedBy: loginController.loginData.single.clientId,
                      modifiedDate: DateTime.now().toIso8601String(),
                    );

                    await registerClientController.registerClient(
                      loginController.loginData.single.accessToken ?? '',
                      newClient,
                    );
                    if (registerClientController
                            .registerClientResponse
                            .value
                            .data !=
                        null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Client registered successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Something went wrong while registering client',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  title: Obx(() {
                    if (registerClientController.isLoading.value) {
                      return CircularProgressIndicator();
                    }
                    return Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    );
                  }),
                ),

                // Center(
                //   child: Container(
                //     height: 50,
                //     width: MediaQuery.of(context).size.width * 0.85,
                //     decoration: BoxDecoration(
                //       color: Colors.blueGrey,
                //       borderRadius: BorderRadius.circular(25),

                //     ),
                //     child: TextButton(
                //       onPressed: () async {

                //       },
                //       child: ,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(String text, {bool withUpload = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: color.awesomeGrey,
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
}
