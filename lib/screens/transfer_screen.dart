import 'package:dropdown_search/dropdown_search.dart';
import 'package:ed_sales/services/controller/login_controller.dart';
import 'package:ed_sales/services/controller/office_controller.dart';
import 'package:ed_sales/services/controller/reasons_controller.dart';
import 'package:ed_sales/services/controller/staff_controller.dart';
import 'package:ed_sales/services/models/requestby_id.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../services/controller/transfer_controller.dart';
import '../services/get_reasons_service.dart';
import '../services/officeservice.dart';
import '../services/staff_service.dart';

class TransferScreen extends StatefulWidget {
  final RequestbyId request;
  const TransferScreen({super.key, required this.request});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TransferController controller = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.savedDevices.isEmpty
                ? 'Transfer Device'
                : 'Device count ${controller.savedDevices.length}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),

          onPressed: () {
            Navigator.pop(context);
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
        backgroundColor: Colors.blueGrey[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Request ID (Reactive)
            TextField(
              readOnly: true,
              controller:
                  TextEditingController(
                      text: widget.request.requestId.toString(),
                    )
                    ..selection = TextSelection.collapsed(
                      offset: widget.request.requestId.toString().length,
                    ),
              decoration: InputDecoration(
                labelText: 'Request ID',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 12),

            // Quantity
            TextField(
              readOnly: true,
              controller:
                  TextEditingController(
                      text: widget.request.noOfDeviceRequested.toString(),
                    )
                    ..selection = TextSelection.collapsed(
                      offset: widget.request.noOfDeviceRequested
                          .toString()
                          .length,
                    ),
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 12),

            // Office Dropdown
            _buildSelectOffice(),
            const SizedBox(height: 12),

            // Staff Dropdown
            _buildSelectStaffs(),
            const SizedBox(height: 12),

            // Reason Dropdown
            _buildSelectReasons(),
            const SizedBox(height: 24),

            // Buttons Row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.openOptionDialog,
                    child: const Text('Serial Number'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: handle transfer
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[700],
                    ),
                    child: const Text('Transfer'),
                  ),
                ),
              ],
            ),

            // Option Dialog
            Obx(
              () => controller.showOptionDialog.value
                  ? _buildOptionDialog(context)
                  : const SizedBox(),
            ),

            // Input Dialog
            Obx(
              () => controller.showInputDialog.value
                  ? _buildInputDialog(context)
                  : const SizedBox(),
            ),

            // Saved Devices List
            Obx(() {
              if (controller.savedDevices.isEmpty) return const SizedBox();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Saved Devices:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...controller.savedDevices.map(
                    (d) => ListTile(
                      title: Text(d),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.savedDevices.remove(d),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Serial Number'),
      content: const Text('Please choose input type of Serial number'),
      actions: [
        TextButton(
          onPressed: () {
            controller.closeOptionDialog();
            controller.openInputDialog();
          },
          child: const Text('Manual'),
        ),
        TextButton(
          onPressed: () {
            controller.closeOptionDialog();
            // TODO: camera logic
          },
          child: const Text('Camera'),
        ),
      ],
    );
  }

  Widget _buildInputDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Serial Number'),
      content: TextField(
        onChanged: (val) => controller.serialNumber.value = val,
        decoration: const InputDecoration(hintText: 'Serial Number'),
      ),
      actions: [
        TextButton(
          onPressed: controller.closeInputDialog,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.serialNumber.value.isNotEmpty) {
              controller.savedDevices.add(controller.serialNumber.value);
            }
            controller.closeInputDialog();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  final StaffController staffController = Get.put(
    StaffController(StaffService()),
  );

  final ReasonsController reasonsController = Get.put(
    ReasonsController(ReasonsService()),
  );

  final OfficeController officeController = Get.put(
    OfficeController(OfficeService()),
  );

  final LoginController loginController = Get.find<LoginController>();
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    String token = loginController.loginData.single.accessToken ?? '';
    await staffController.getStaffData(token);
    await reasonsController.getReasonsData(token);
    await officeController.getOfficesData(token);
  }

  String selectedStaff = 'Select Staff';
  String selectedReason = 'Select Reason';
  String selectedOffice = 'Select Office';

  Widget _buildSelectOffice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: awesomeGrey),
      child: Obx(() {
        if (officeController.isLoading.value) {
          return Center(child: AppUtils.getLoader);
        } else if (officeController.errorMessage.isNotEmpty) {
          return Center(child: Text(officeController.errorMessage.value));
        }
        final offices = officeController.officeData;
        debugPrint('Office Data: $offices');

        return DropdownSearch<String>(
          items: (filter, loadProps) => offices
              .map((office) => office.officeName.toString())
              .toList(), // your list of offices
          selectedItem: selectedOffice != 'Select Office'
              ? selectedOffice
              : null,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "Select Office", // fixed hint
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
                hintText: "Search office...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              selectedOffice = value.toString();
            });
          },
        );
      }),
    );
  }

  Widget _buildSelectReasons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: awesomeGrey),
      child: Obx(() {
        if (reasonsController.isLoading.value) {
          return Center(child: AppUtils.getLoader);
        } else if (reasonsController.errorMessage.isNotEmpty) {
          return Center(child: Text(reasonsController.errorMessage.value));
        }
        final reasons = reasonsController.reasonsData;
        debugPrint('Reasons Data: $reasons');

        return DropdownSearch<String>(
          items: (filter, loadProps) => reasons
              .map((reason) => reason.discription.toString())
              .toList(), // your list of reasons
          selectedItem: selectedReason != 'Select Reason'
              ? selectedReason
              : null,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "Select Reason", // fixed hint
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
                hintText: "Search reason...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              selectedReason = value.toString();
            });
          },
        );
      }),
    );
  }

  Widget _buildSelectStaffs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: awesomeGrey),
      child: Obx(() {
        if (staffController.isLoading.value) {
          return Center(child: AppUtils.getLoader);
        } else if (staffController.errorMessage.isNotEmpty) {
          return Center(child: Text(staffController.errorMessage.value));
        }
        final staffs = staffController.staffData;
        debugPrint('Staff Data: $staffs');

        return DropdownSearch<String>(
          items: (filter, loadProps) => staffs
              .map((staff) => "${staff.firstName} ${staff.lastName}")
              .toList(), // your list of staffs
          selectedItem: selectedStaff != 'Select Staff' ? selectedStaff : null,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "Select Staff", // fixed hint
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
                hintText: "Search staff...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              selectedStaff = value.toString();
            });
          },
        );
      }),
    );
  }
}
