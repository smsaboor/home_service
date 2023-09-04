import 'package:lucknow_home_services/feature/checkout/repo/checkout_repo.dart';
import 'package:lucknow_home_services/feature/checkout/repo/schedule_repo.dart';
import 'package:lucknow_home_services/feature/conversation/repo/conversation_repo.dart';
import 'package:lucknow_home_services/feature/create_post/controller/create_post_controller.dart';
import 'package:lucknow_home_services/feature/create_post/repository/create_post_repo.dart';
import 'package:lucknow_home_services/feature/provider/controller/provider_booking_controller.dart';
import 'package:lucknow_home_services/feature/provider/repository/provider_booking_repo.dart';
import 'package:lucknow_home_services/feature/web_landing/controller/web_landing_controller.dart';
import 'package:lucknow_home_services/feature/web_landing/repository/web_landing_repo.dart';
import 'package:get/get.dart';
import 'package:lucknow_home_services/core/core_export.dart';
import 'package:lucknow_home_services/feature/html/controller/webview_controller.dart';
import 'package:lucknow_home_services/feature/html/repository/html_repo.dart';
import 'package:lucknow_home_services/feature/notification/repository/notification_repo.dart';
import 'package:lucknow_home_services/feature/service_booking/repo/booking_details_repo.dart';
import 'package:lucknow_home_services/feature/voucher/controller/coupon_controller.dart';
export 'package:lucknow_home_services/feature/cart/repository/cart_repo.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AuthController(authRepo: AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    Get.lazyPut(() => NotificationController( notificationRepo: NotificationRepo(apiClient:Get.find() , sharedPreferences: Get.find())));
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => CouponController(couponRepo: CouponRepo(apiClient: Get.find())));
    Get.lazyPut(() => ScheduleController(scheduleRepo: ScheduleRepo(apiClient: Get.find())));
    Get.lazyPut(() => BookingDetailsTabsController(bookingDetailsRepo: BookingDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AllSearchController(searchRepo: SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));
    Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
    Get.lazyPut(() => CheckOutController(checkoutRepo: CheckoutRepo(apiClient: Get.find())));
    Get.lazyPut(() => ProviderBookingController(providerBookingRepo: ProviderBookingRepo(apiClient: Get.find())));
    Get.lazyPut(() => CreatePostController(createPostRepo: CreatePostRepo(apiClient: Get.find())));
  }
}