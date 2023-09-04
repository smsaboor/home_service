import 'package:lucknow_home_services/core/core_export.dart';
import 'package:lucknow_home_services/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:lucknow_home_services/feature/wallet/model/wallet_transaction_model.dart';
import 'package:lucknow_home_services/feature/wallet/repository/wallet_repo.dart';
import 'package:get/get.dart';

class WalletController extends GetxController{
  final WalletRepo walletRepo;
  WalletController({required this.walletRepo});

  final bool _isLoading= false;
  bool get isLoading => _isLoading;
  WalletTransactionModel? walletTransactionModel;
  List<LoyaltyPointTransactionData> listOfTransaction = [];


  Future<void> getWalletTransactionData(int offset,{reload = false}) async {

    if(reload){
      walletTransactionModel= null;
      update();
    }
    Response response = await walletRepo.getWalletTransactionData(offset);
    if(response.statusCode == 200){
      walletTransactionModel = WalletTransactionModel.fromJson(response.body);
      if(offset!=1){
        listOfTransaction.addAll(walletTransactionModel!.content!.transactions!.data!);
      }else{
        listOfTransaction = [];
        listOfTransaction.addAll(walletTransactionModel!.content!.transactions!.data!);
      }
    }
    else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}