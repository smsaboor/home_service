import 'package:lucknow_home_services/feature/wallet/controller/wallet_controller.dart';
import 'package:lucknow_home_services/feature/wallet/repository/wallet_repo.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController(walletRepo: WalletRepo(apiClient: Get.find())));
  }
}