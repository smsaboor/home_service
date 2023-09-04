import 'package:lucknow_home_services/data/provider/client_api.dart';
import 'package:lucknow_home_services/feature/notification/repository/notification_repo.dart';
import 'package:lucknow_home_services/utils/app_constants.dart';

class WebLandingRepo {
  final ApiClient apiClient;

  WebLandingRepo({required this.apiClient});

  Future<Response> getWebLandingContents() async {
    return await apiClient.getData(AppConstants.webLandingContents,headers: AppConstants.configHeader);
  }

}