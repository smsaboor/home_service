import 'package:get/get.dart';
import 'package:lucknow_home_services/core/core_export.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() async {

    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ServiceController(
        serviceRepo: ServiceRepo(apiClient: ApiClient(
           appBaseUrl: AppConstants.baseUrl,
           sharedPreferences: sharedPreferences))
    ));
  }
}