import 'package:ed_sales/services/dashboard_service.dart';
import 'package:ed_sales/services/models/top_sellers.dart';
import 'package:get/get.dart';

import '../models/dashboard.dart';
import '../repository/topSellers_service.dart';
import '../utils.dart';

class HomeController extends GetxController {
  final DashboardService service;
  final TopsellersService topSellersService;

  HomeController(this.service, this.topSellersService);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var isLoadingTopSellers = false.obs;
  var errorMessageTopSellers = ''.obs;

  var dashboardData = <Dashboard>[].obs;
  var topSellersData = <TopSellers>[].obs;

  Future<void> getTopSellersData(String token) async {
    isLoadingTopSellers.value = true;
    errorMessageTopSellers.value = '';

    final result = await topSellersService.getTopSellers(token);

    isLoadingTopSellers.value = false;

    switch (result.status) {
      case Status.loading:
        isLoadingTopSellers.value = true;
        break;
      case Status.success:
        topSellersData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessageTopSellers.value = result.message ?? "Something went wrong";
        break;
    }
  }

  Future<void> getDashboardData(int officeId, String token) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await service.getDashboardData(officeId, token);

    isLoading.value = false;

    switch (result.status) {
      case Status.loading:
        isLoading.value = true;
        break;
      case Status.success:
        dashboardData.value = result.data ?? [];
        break;
      case Status.error:
        errorMessage.value = result.message ?? "Something went wrong";
        break;
    }
  }
}
