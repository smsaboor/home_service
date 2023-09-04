import 'package:get/get.dart';
import 'package:lucknow_home_services/core/core_export.dart';
import 'package:lucknow_home_services/feature/profile/controller/edit_profile_tab_controller.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => EditProfileTabController(userRepo: UserRepo(apiClient: Get.find())));
  }
}