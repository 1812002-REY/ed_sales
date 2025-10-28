// import 'package:flutter/cupertino.dart';
import 'package:ed_sales/constants.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller/Efd_controller.dart';
import '../services/controller/login_controller.dart';
import '../services/controller/vfd_controller.dart';
import '../services/models/notification.dart';
import '../services/repository/Efd_service.dart';
import '../services/repository/vfd_service.dart';
import '../services/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final EfdController efdController = Get.put(EfdController(EfdService()));
  final VfdController vfdController = Get.put(VfdController(VfdService()));
  final loginController = Get.find<LoginController>();

  bool isVfd = false; // default EFD

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    String token = loginController.loginData.single.accessToken ?? '';
    int officeId = loginController.loginData.single.officeId ?? 0;

    await efdController.getEfdData(token, officeId);
    await vfdController.getVfdData(token);
  }

  List<NotificationOffice> _getEfdNotifications() {
    final efdNotifs = AppUtils.getNotificationsFromEfd(efdController.efdData);
    efdNotifs.sort((a, b) => b.createDate.compareTo(a.createDate));
    return efdNotifs;
  }

  List<NotificationOffice> _getVfdNotifications() {
    final vfdNotifs = AppUtils.getNotificationsFromVfd(vfdController.vfdData);
    vfdNotifs.sort((a, b) => b.createDate.compareTo(a.createDate));
    return vfdNotifs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Notifications",style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh,color: Colors.white,),
            onPressed: _loadNotifications,
          ),
        ],
      ),
      body: Obx(() {
        if (efdController.isLoading.value || vfdController.isLoading.value) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 16,
            ),
          );
        }

        if (efdController.errorMessage.isNotEmpty ||
            vfdController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              efdController.errorMessage.isNotEmpty
                  ? efdController.errorMessage.value
                  : vfdController.errorMessage.value,
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        final notifications =
            isVfd ? _getVfdNotifications() : _getEfdNotifications();

        if (notifications.isEmpty) {
          return const Center(
            child: Text(
              "No notifications available",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 10),
            // 🔁 Switch Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _switchButton("EFD", !isVfd, () {
                    setState(() => isVfd = false);
                  }),
                  _switchButton("VFD", isVfd, () {
                    setState(() => isVfd = true);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 🔔 Notifications List
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadNotifications,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: awesomeGrey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications,
                          color: isVfd ? Colors.black : Colors.black54,
                        ),
                        title: Text(
                          notif.notificationState,
                          style: TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notif.deviceSerialNumber,
                            ),
                            Text(
                              notif.notificationState.isEmpty
                                  ? "No Status yet"
                                  : "Device is ready for ${notif.notificationState}",
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              notif.formattedDate,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
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
        style: TextStyle(color: active ? Colors.white : Colors.black,fontSize: 14),
      ),
    );
  }
}
