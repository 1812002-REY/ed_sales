// import 'package:ed_sales/constants.dart';
import 'package:ed_sales/constants.dart' show appColor, awesomeGrey, buttonTextColor, lightBlue;
import 'package:ed_sales/screens/softnet_login_page.dart';
import 'package:ed_sales/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller/home_controller.dart';
import '../services/controller/login_controller.dart';
import '../services/dashboard_service.dart';
import '../services/repository/topSellers_service.dart';
import '../widgets/home_top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final loginController = Get.find<LoginController>();
  final HomeController homeController = Get.put(
    HomeController(DashboardService(), TopsellersService()),
  );

  // ✅ Common text style for the whole page
  // final TextStyle commonTextStyle = const TextStyle(
  //   color: Colors.white,
  //   fontSize: 16,
  //   fontWeight: FontWeight.w600,
  // );

  @override
  void initState() {
    super.initState();
    getDashboardData();
    getTopSellersData();
  }

  getTopSellersData() {
    String token = loginController.loginData.single.accessToken ?? '';
    homeController.getTopSellersData(token);
  }

  assertTopSellersData() {
    return Obx(() {
      if (homeController.isLoadingTopSellers.value) {
        return Center(child: AppUtils.getLoader);
      } else if (homeController.errorMessageTopSellers.isNotEmpty) {
        return Center(child: Text(homeController.errorMessageTopSellers.value));
      } else if (homeController.topSellersData.isEmpty) {
        return const Center(child: Text('No top sellers data found'));
      } else {
        final topSellersList = homeController.topSellersData;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: topSellersList.map((seller) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.fullName.toString().split(" ")[0],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        seller.fullName.toString().split(" ")[1],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text('${seller.deviceSold}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seller.officeName.toString().split(" ")[0],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          seller.officeName.toString().split(" ").last,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }
    });
  }

  getDashboardData() {
    int officeId = loginController.loginData.single.officeId ?? 0;
    String token = loginController.loginData.single.accessToken ?? '';
    homeController.getDashboardData(officeId, token);
  }

  assertDashboardData() {
    return Obx(() {
      if (homeController.isLoading.value) {
        return Center(child: AppUtils.getLoader);
      } else if (homeController.errorMessage.isNotEmpty) {
        return Center(child: Text(homeController.errorMessage.value));
      } else if (homeController.dashboardData.isEmpty) {
        return const Center(child: Text('No dashboard data found'));
      } else {
        final dashboardList = homeController.dashboardData;

        final List<Map<String, dynamic>> items = [
          {
            "title": "Device in stock",
            "count": dashboardList.single.deviceInStock ?? 0,
            "icon": Icons.shopping_cart,
          },
          {
            "title": "Device Sold",
            "count": dashboardList.single.solDevices ?? 0,
            "icon": Icons.attach_money_outlined,
          },
          {
            "title": "Device to be invoiced",
            "count": dashboardList.single.soldDeviceCurrent ?? 0,
            "icon": Icons.feed_sharp,
          },
          {
            "title": "Device Transferred",
            "count": dashboardList.single.transferedDevices ?? 0,
            "icon": Icons.compare_arrows_sharp,
          },
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: awesomeGrey,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item["title"], style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${item["count"]}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                      Icon(item["icon"], size: 32, color: Colors.black),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blueGrey,
        title: Text(
          "EFD",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 20,
            color: buttonTextColor
          ), // AppBar font kubwa kidogo
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            iconColor: buttonTextColor,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 3,
                  child: const Text("Logout"),
                  onTap: () => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SoftNetLoginPage(),
                      ),
                      (route) => false,
                    ),
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const HomeTopBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppUtils.getMonthYear(), style: Theme.of(context).textTheme.titleSmall),
                assertDashboardData(),
                Text(AppUtils.getFullDate(), style: Theme.of(context).textTheme.titleSmall),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: awesomeGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.attach_money_outlined,
                        size: 30,
                        color: Colors.black,
                      ),

                      Text("Device Sold", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                      Text(
                        "${homeController.dashboardData.isNotEmpty ? homeController.dashboardData.single.solDevices ?? 0 : 0}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
               
              ],
            ),
          ),
          Text(AppUtils.getMonthYear(), style: Theme.of(context).textTheme.titleSmall),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: awesomeGrey,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Text(
                    "Top Sellers People",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: SingleChildScrollView(
                            child: assertTopSellersData(),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.people,
                            size: 85,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
