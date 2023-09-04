import 'dart:math';
import 'package:lucknow_home_services/core/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknow_home_services/components/custom_image.dart';
import 'package:lucknow_home_services/core/helper/help_me.dart';
import 'package:lucknow_home_services/feature/home/controller/campaign_controller.dart';
import 'package:lucknow_home_services/feature/splash/controller/splash_controller.dart';
import 'package:lucknow_home_services/utils/dimensions.dart';
import 'package:lucknow_home_services/utils/images.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RandomCampaignView extends StatelessWidget {
   const RandomCampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(
        builder: (campaignController) {
          int randomIndex = 1;
          if(campaignController.campaignList != null && campaignController.campaignList!.isEmpty){
            return const SizedBox();
          }else{
            String? baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
            if(campaignController.campaignList != null) {
              var rng = Random();
              randomIndex =  rng.nextInt(campaignController.campaignList!.isNotEmpty ? campaignController.campaignList!.length :1 );
              return InkWell(
                onTap: (){
                  if(isRedundentClick(DateTime.now())){
                    return;
                  }
                  campaignController.navigateFromCampaign(
                      campaignController.campaignList![randomIndex].id!,
                      campaignController.campaignList![randomIndex].discount!.discountType!);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight),),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight),
                          child: CustomImage(
                            height: ResponsiveHelper.isTab(context) || MediaQuery.of(context).size.width > 450 ? 350 :MediaQuery.of(context).size.width * 0.40,
                            width: Get.width, fit: BoxFit.cover, placeholder: Images.placeholder,
                            image:'$baseUrl/campaign/${campaignController.campaignList![randomIndex].coverImage}',),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: ResponsiveHelper.isTab(context) ? 300 : GetPlatform.isDesktop ? 500 : MediaQuery.of(context).size.width * 0.40,
                child:  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Shimmer(
                      duration: const Duration(seconds: 2),
                      enabled: true,
                      color: Colors.grey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.isDarkMode? Colors.grey[700]:Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                        ),
                      )
                  ),
                ),
              );
            }
          }
        });
  }
}
