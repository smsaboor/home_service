import 'package:get/get.dart';
import 'package:lucknow_home_services/core/core_export.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => AllSearchController(searchRepo: SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }
}