import 'package:get/get.dart';
import 'package:lucknow_home_services/core/core_export.dart';
import 'package:lucknow_home_services/feature/conversation/repo/conversation_repo.dart';
import 'package:lucknow_home_services/feature/service_booking/repo/booking_details_repo.dart';

class BookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BookingDetailsTabsController(bookingDetailsRepo: BookingDetailsRepo(
      sharedPreferences: Get.find(),
      apiClient: Get.find(),
    )));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    ///conversation controller is used in booking details screen
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
  }
}