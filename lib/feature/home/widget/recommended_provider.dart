import 'package:lucknow_home_services/core/core_export.dart';
import 'package:lucknow_home_services/feature/provider/controller/provider_booking_controller.dart';
import 'package:lucknow_home_services/feature/provider/widgets/provider_item_view.dart';
import 'package:get/get.dart';

class HomeRecommendProvider extends StatelessWidget {
  const HomeRecommendProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderBookingController>(
      builder: (providerBookingController){
        if(providerBookingController.providerList != null && providerBookingController.providerList!.isEmpty){
          return const SizedBox();
        }
        else{
          if(providerBookingController.providerList != null){
            return Container(
              decoration: BoxDecoration(color: Get.isDarkMode?Theme.of(context).hintColor.withOpacity(0.3) :Theme.of(context).primaryColor.withOpacity(0.1),),
              child: Stack(children: [
                Image.asset(Images.homeProviderBackground,height: Get.find<LocalizationController>().isLtr? 210:230,width: Get.width,fit: BoxFit.cover,),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('recommended_experts_for_you'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                        InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getAllProviderRoute()),
                          child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                            decoration: TextDecoration.underline,
                            color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.isMobile(context)? 160: 170,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      itemCount: providerBookingController.providerList?.length,
                      itemBuilder: (context, index){
                        return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                          child: SizedBox(
                            width: ResponsiveHelper.isDesktop(context)? Get.width/ 4: ResponsiveHelper.isTab(context)? Get.width/ 2:  Get.width/1.16,
                            child: ProviderItemView(providerData: providerBookingController.providerList![index],),
                          ),
                        );
                      },
                    ),
                  ),
                ])],
              ),
            );
          }else{
            return const SizedBox();
          }
        }
    });
  }
}
