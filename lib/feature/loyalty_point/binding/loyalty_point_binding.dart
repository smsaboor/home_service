import 'package:lucknow_home_services/feature/loyalty_point/controller/loyalty_point_controller.dart';
import 'package:lucknow_home_services/feature/loyalty_point/repository/loyalty_point_repo.dart';
import 'package:get/get.dart';

class LoyaltyPointBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoyaltyPointController(loyaltyPointRepo: LoyaltyPointRepo(apiClient: Get.find())));
  }
}