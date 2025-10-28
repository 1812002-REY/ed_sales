import 'package:ed_sales/constants.dart';
import 'package:ed_sales/screens/invoice_screen.dart';
import 'package:ed_sales/screens/sale_efd_screen.dart';
import 'package:ed_sales/screens/softnet_login_page.dart';
import 'package:ed_sales/services/controller/Efd_controller.dart';
import 'package:ed_sales/services/controller/home_controller.dart';
import 'package:ed_sales/services/controller/login_controller.dart';
import 'package:ed_sales/services/controller/requestbyIdcontroller.dart'
    show Requestbyidcontroller;
import 'package:ed_sales/services/controller/vfd_controller.dart';
import 'package:ed_sales/services/models/efd_device.dart';
import 'package:ed_sales/services/repository/Efd_service.dart';
import 'package:ed_sales/services/repository/requestbyidservice.dart'
    show RequestbyIdService;
import 'package:ed_sales/services/repository/vfd_service.dart';
import 'package:ed_sales/services/utils.dart' show AppUtils;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller/home_controller.dart' show HomeController;
import 'sale_vfd_screen.dart';
import 'transfer_screen.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  bool isVfd = true;

  final loginController = Get.find<LoginController>();
  final homeController = Get.find<HomeController>();
  final VfdController vfdController = Get.put(VfdController(VfdService()));
  final EfdController efdController = Get.put(EfdController(EfdService()));
  final Requestbyidcontroller requestbyIdcontroller = Get.put(
    Requestbyidcontroller(RequestbyIdService()),
  );

  @override
  void initState() {
    super.initState();
    // Fetch data once after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
     _loadVfdData();
     _loadEfdData();
    });
  }
  
  _loadVfdData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    await vfdController.getVfdData(token);
  }

  _loadEfdData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    int officeId = loginController.loginData.single.officeId ?? 0;
    await efdController.getEfdData(token, officeId);
  }

  // ---------------- VFD LIST ----------------
  Widget _vfdList() {
    return Obx(() {
      if (vfdController.isLoading.value) {
        return Center(child: AppUtils.getLoader);
      }
      if (vfdController.errorMessage.isNotEmpty) {
        return Center(child: Text(vfdController.errorMessage.value));
      }
      if (vfdController.filteredData.isEmpty) {
        return const Center(child: Text("No VFD devices found."));
      }

      final data = vfdController.filteredData;
      data.sort((a, b) {
        final dateA = DateTime.tryParse(a.dateUpdated.toString());
        final dateB = DateTime.tryParse(b.dateUpdated.toString());
        // If both are invalid → keep original order
        if (dateA == null && dateB == null) return 0;

        // If only A is invalid → push A below B
        if (dateA == null) return 1;

        // If only B is invalid → push B below A
        if (dateB == null) return -1;

        // Both valid → sort newest first
        return dateB.compareTo(dateA);
      });
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final device = data[index];
          return Card(
            color: awesomeGrey,
            child: ListTile(
              leading: Image.asset("assets/pos.png"),
              title: Text(
                device.deviceId ?? 'Unknown Model',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              subtitle: Text(
                device.dateUpdated == null
                    ? 'Unknown Date'
                    : AppUtils.formatDate(device.dateUpdated.toString()),
                style: const TextStyle(color: Colors.black),
              ),
              trailing: _statusBadge(
                AppUtils.getButtonLabel(
                  device.operationStatus!,
                  device.paymentStatus!,
                  !isVfd,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ---------------- EFD LIST ----------------
  Widget _efdList() {
    return Obx(() {
      if (efdController.isLoading.value) {
        return Center(child: AppUtils.getLoader);
      }
      if (efdController.errorMessage.isNotEmpty) {
        return Center(child: Text(efdController.errorMessage.value));
      }
      if (efdController.filteredData.isEmpty) {
        return const Center(child: Text("No EFD devices found."));
      }

      var data = efdController.filteredData;
      data.sort((a, b) {
        final dateA = DateTime.tryParse(a.dateUpdated.toString());
        final dateB = DateTime.tryParse(b.dateUpdated.toString());

        // If both are invalid → keep original order
        if (dateA == null && dateB == null) return 0;

        // If only A is invalid → push A below B
        if (dateA == null) return 1;

        // If only B is invalid → push B below A
        if (dateB == null) return -1;

        // Both valid → sort newest first
        return dateB.compareTo(dateA);
      });

      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final device = data[index];
          return Card(
            color: awesomeGrey,
            child: ListTile(
              leading: Image.asset("assets/pos.png"),
              title: Text(
                device.serialNumber ?? 'Unknown Model',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  // fontSize: 10
                ),
              ),
              subtitle: Text(
                device.dateUpdated == null
                    ? 'Unknown Date'
                    : AppUtils.formatDate(device.dateUpdated.toString()),
                style: const TextStyle(color: Colors.black),
              ),
              trailing: _statusBadge(
                AppUtils.getButtonLabel(
                  device.operationStatus!,
                  device.paymentStatus!,
                  !isVfd,
                ),
              ),
              onTap: () {
                if (!isVfd && device.operationStatus == 8) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InvoiceScreen(fromEFD: true, efdDevice: device),
                    ),
                  );
                } else if (!isVfd && device.operationStatus == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaleEFDPage(efdDevice: device),
                    ),
                  );
                }
              },
            ),
          );
        },
      );
    });
  }

  Widget _statusBadge(String label) {
    return Container(
      width: 100,
      height: 30,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("EFD",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 20,
            color: buttonTextColor
          ) ),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon:  Icon(Icons.feed_sharp,color: buttonTextColor,), onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              isVfd ? _loadVfdData() : _loadEfdData();
            });
          }),
          IconButton(
            icon:  Icon(Icons.crop,color: buttonTextColor,),
            onPressed: () {
              final token = loginController.loginData.single.accessToken ?? '';
              final TextEditingController requestIdController =
                  TextEditingController();

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Enter Request ID"),
                  content: TextField(
                    controller: requestIdController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Request ID"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        final requestId = requestIdController.text.trim();
                        if (requestId.isEmpty) {
                          // Warn if empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter a Request ID"),
                            ),
                          );
                          return;
                        }

                        // Call API
                        await requestbyIdcontroller.getRequestbyidData(
                          token,
                          int.parse(requestId),
                        );

                        if (requestbyIdcontroller.requestbyidData.isNotEmpty) {
                          final device =
                              requestbyIdcontroller.requestbyidData.first;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TransferScreen(request: device,),
                            ),
                          );
                        } else {
                          // No device found alert
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("No device found"),
                              content: const Text(
                                "No device exists for this Request ID.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              );
            },
          ),

          PopupMenuButton(
            iconColor: buttonTextColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 3,
                child: const Text("Logout"),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SoftNetLoginPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            if (!isVfd)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: awesomeGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(flex: 1, child: Icon(Icons.bar_chart, size: 60)),

                    // Icon(Icons.bar_chart, size: 70),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "DISTRIBUTED",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${homeController.dashboardData.single.notConfirmedDevices}",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "INSTOCK",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${homeController.dashboardData.single.deviceInStock}",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "SOLD",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${homeController.dashboardData.single.solDevices}",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            // Switch Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _switchButton(
                  "EFD",
                  !isVfd,
                  () => setState(() => isVfd = false),
                ),
                _switchButton("VFD", isVfd, () {
                  setState(() => isVfd = true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SaleVFDPage()),
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText:
                      'Search by ${isVfd ? 'Device ID' : 'Serial Number'}',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => isVfd
                    ? vfdController.searchBySerial(value)
                    : efdController.searchBySerial(value),
              ),
            ),
            const SizedBox(height: 5),

            // Device List
            Expanded(child: isVfd ? _vfdList() : _efdList()),
          ],
        ),
      ),
    );
  }

  Widget _switchButton(String label, bool active, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active ? Colors.blueGrey : awesomeGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: Size(
          MediaQuery.of(context).size.width / 2 - 24,
          MediaQuery.of(context).size.height * 0.045,
        ),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: active ? Colors.white : Colors.black,
              fontSize: 12
            ),
      ),
    );
  }
}
