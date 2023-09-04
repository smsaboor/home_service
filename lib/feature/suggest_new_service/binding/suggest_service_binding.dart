import 'package:lucknow_home_services/feature/suggest_new_service/controller/suggest_service_controller.dart';
import 'package:lucknow_home_services/feature/suggest_new_service/repository/suggest_service_repo.dart';
import 'package:get/get.dart';

class SuggestServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SuggestServiceController(suggestServiceRepo: SuggestServiceRepo(apiClient: Get.find())));
  }
}