import 'dart:async';
import 'package:lucknow_home_services/components/custom_image.dart';
import 'package:lucknow_home_services/components/footer_base_view.dart';
import 'package:lucknow_home_services/controller/localization_controller.dart';
import 'package:lucknow_home_services/data/model/response/config_model.dart';
import 'package:lucknow_home_services/feature/location/widget/registration_card.dart';
import 'package:lucknow_home_services/feature/splash/controller/splash_controller.dart';
import 'package:lucknow_home_services/feature/web_landing/controller/web_landing_controller.dart';
import 'package:lucknow_home_services/feature/web_landing/repository/web_landing_repo.dart';
import 'package:lucknow_home_services/feature/web_landing/widget/live_chat_button.dart';
import 'package:lucknow_home_services/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:lucknow_home_services/feature/web_landing/widget/web_landing_shimmer.dart';
import 'package:lucknow_home_services/feature/web_landing/widget/web_mid_section.dart';
import 'package:lucknow_home_services/utils/dimensions.dart';
import 'package:lucknow_home_services/utils/images.dart';
import 'package:lucknow_home_services/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'widget/testimonial_widget.dart';

class WebLandingPage extends StatefulWidget {
  final bool? fromSignUp;
  final String? route;

  const WebLandingPage({Key? key, required this.fromSignUp, required this.route}) : super(key: key);

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  final ConfigModel _config = Get.find<SplashController>().configModel;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    Get.find<WebLandingController>().getWebLandingContent();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    String baseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;

    return GetBuilder<WebLandingController>(

      builder: (webLandingController){
        if(webLandingController.webLandingContent != null){
          var textContent = { for (var e in webLandingController.webLandingContent!.textContent!) e.keyName : e.liveValues };
          var imageContent = { for (var e in webLandingController.webLandingContent!.imageContent!) e.keyName : e.liveValues };


          return FooterBaseView(
            bottomPadding: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  WebLandingSearchSection(baseUrl: baseUrl,textContent: textContent,fromSignUp:widget.fromSignUp,route: widget.route,),
                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                  WebMidSection(
                    baseUrl: baseUrl,
                    imageContent: imageContent,
                    textContent: textContent,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                  TestimonialWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                  _config.content!.providerSelfRegistration == '1'
                      ? const RegistrationCard(isStore: true)
                      : const SizedBox(),
                  SizedBox(height: _config.content!.providerSelfRegistration == '1' ? 40 : 0),
                  SizedBox(
                    height: 570.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: Dimensions.webMaxWidth,
                        child: Row(
                          mainAxisAlignment: _config.content!.appUrlAndroid == null && _config.content!.appUrlIos == null
                              ? MainAxisAlignment.center
                              :MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //download section image
                            CustomImage(
                              height: Dimensions.webLandingDownloadImageHeight,
                              width:  Dimensions.webLandingDownloadImageHeight,
                              image: "$baseUrl/landing-page/web/${imageContent['download_section_image']}",
                              fit: BoxFit.fitHeight,
                            ),
                            //download app section
                            if(imageContent.isNotEmpty &&( _config.content!.appUrlAndroid != null || _config.content!.appUrlIos != null)) Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(width: 50,height: 2,color:Get.isDarkMode ?Colors.white:Colors.black),
                                    const SizedBox(width: 8.0,),
                                    Text(textContent['download_section_title']??"", textAlign: TextAlign.center, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                Text(
                                 textContent['download_section_description']??"",
                                  textAlign: TextAlign.center,
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color,
                                      fontSize: Dimensions.fontSizeDefault),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeLarge),
                                  Row(
                                  children: [
                                   if( _config.content!.appUrlAndroid != null)
                                    InkWell(
                                      onTap: () async {
                                        if(await canLaunchUrlString(_config.content!.appUrlAndroid!)) {launchUrlString(_config.content!.appUrlAndroid!);
                                        }},
                                      child: Image.asset(Images.playStoreIcon, height: 45),
                                    ) ,

                                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                                    if(_config.content!.appUrlIos != null )
                                      InkWell(
                                      onTap: () async {
                                        if(await canLaunchUrlString(_config.content!.appUrlIos!)) {
                                          launchUrlString(_config.content!.appUrlIos!);
                                        }
                                        },
                                      child: Image.asset(Images.appStoreIcon, height: 45),)

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Dimensions.webLandingContactUsHeight,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode?Colors.grey.withOpacity(0.1):Theme.of(context).primaryColorLight,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: Dimensions.webMaxWidth,
                            child: Align(
                              alignment:Get.find<LocalizationController>().isLtr ? Alignment.centerLeft: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(textContent['web_bottom_title'] != null && textContent['web_bottom_title'] != '')
                                  Text(textContent['web_bottom_title']!,style: ubuntuBold.copyWith(fontSize: 18),),
                                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LiveChatButton(
                                          title:'chat'.tr,
                                          iconData:Icons.message,
                                          isBorderActive:false,
                                      ),
                                      const SizedBox(width:Dimensions.paddingSizeDefault),
                                      LiveChatButton(
                                          title:Get.find<SplashController>().configModel.content!.businessPhone!,
                                          iconData:Icons.call,
                                          isBorderActive:true,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right:Get.find<LocalizationController>().isLtr ? Get.width/7 : null,
                          left:Get.find<LocalizationController>().isLtr ?null: Get.width / 7,
                          top: - 65.0,
                          child: CustomImage(image: "$baseUrl/landing-page/web/${imageContent['support_section_image']}",
                            fit: BoxFit.cover,
                            width: Dimensions.supportLogoWidth,height:  Dimensions.supportLogoHeight,),
                        ),
                      ],
                    ),
                  ),
                ],),
            ),
          );
        }else{
          return const WebLandingShimmer();
        }
      },
    );
  }
}
class CustomPath extends CustomClipper<Path> {
  final bool? isRtl;
  CustomPath({required this.isRtl});

  @override
  Path getClip(Size size) {
    final path = Path();
    if(isRtl!) {
      path..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width*0.7, 0)
        ..lineTo(0, 0)
        ..close();
    }else {
      path..moveTo(0, size.height)
        ..lineTo(size.width*0.3, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


