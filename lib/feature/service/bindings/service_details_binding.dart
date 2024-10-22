import 'package:get/get.dart';
import 'package:lucknow_home_services/feature/service/controller/service_details_controller.dart';
import 'package:lucknow_home_services/feature/service/controller/service_details_tab_controller.dart';
import 'package:lucknow_home_services/feature/service/repository/service_details_repo.dart';

class ServiceDetailsBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => ServiceDetailsController(serviceDetailsRepo: ServiceDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceTabController(serviceDetailsRepo: ServiceDetailsRepo(apiClient: Get.find())));
  }
}