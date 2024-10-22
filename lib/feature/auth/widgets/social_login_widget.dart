import 'package:lucknow_home_services/components/text_hover.dart';
import 'package:lucknow_home_services/core/helper/responsive_helper.dart';
import 'package:lucknow_home_services/feature/auth/controller/auth_controller.dart';
import 'package:lucknow_home_services/feature/auth/model/social_log_in_body.dart';
import 'package:lucknow_home_services/feature/splash/controller/splash_controller.dart';
import 'package:lucknow_home_services/utils/dimensions.dart';
import 'package:lucknow_home_services/utils/images.dart';
import 'package:lucknow_home_services/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class SocialLoginWidget extends StatelessWidget {
  final String? fromPage;
  const SocialLoginWidget({super.key, this.fromPage});

  @override
  Widget build(BuildContext context) {


    return Column(children: [

      Center(child: Text('or'.tr, style: ubuntuRegular.copyWith(
          color:  Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
          fontSize: Dimensions.fontSizeSmall))),
      const SizedBox(height: Dimensions.paddingSizeDefault),

      Center(child: Text('sign_in_with'.tr, style: ubuntuRegular.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
          fontSize: Dimensions.fontSizeSmall))),
      const SizedBox(height: Dimensions.paddingSizeDefault),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [

        if(Get.find<SplashController>().configModel.content!.googleSocialLogin.toString() == '1')
          InkWell(
            onTap: () async {
              await Get.find<AuthController>().socialLogin();
              String id = '', token = '', email = '', medium ='';
              if(Get.find<AuthController>().googleAccount != null){
                id = Get.find<AuthController>().googleAccount!.id;
                email = Get.find<AuthController>().googleAccount!.email;
                token = Get.find<AuthController>().auth!.idToken!;
                medium = 'google';
              }
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: email, token: token, uniqueId: id, medium: medium,
              ),fromPage: fromPage);
            },
            child: TextHover(
              builder: (hovered){
                return  Container(
                  height: ResponsiveHelper.isDesktop(context)?50 :ResponsiveHelper.isTab(context)? 40:40,
                  width: ResponsiveHelper.isDesktop(context)? 130 :ResponsiveHelper.isTab(context)? 110: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hovered?Theme.of(context).primaryColor.withOpacity(0.1) :Theme.of(context).shadowColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.google,
                        height: ResponsiveHelper.isDesktop(context)?30 :ResponsiveHelper.isTab(context)? 25:20,
                        width: ResponsiveHelper.isDesktop(context)? 30 :ResponsiveHelper.isTab(context)? 25: 20,
                      ),
                      !ResponsiveHelper.isMobile(context)?
                      Row(
                        children: [
                          const SizedBox(width: Dimensions.paddingSizeSmall,),
                          Text('google'.tr,style: ubuntuRegular.copyWith(),)
                        ],
                      ):const SizedBox.shrink()
                    ],
                  ),
                );
              },
            ),
          ),

        if(Get.find<SplashController>().configModel.content!.googleSocialLogin.toString() == '1' && Get.find<SplashController>().configModel.content!.facebookSocialLogin.toString() == '1')
          const SizedBox(width: Dimensions.paddingSizeDefault,),


        if(Get.find<SplashController>().configModel.content!.facebookSocialLogin.toString() == '1')
          InkWell(
          onTap: () async{
            LoginResult result = await FacebookAuth.instance.login();
            if (result.status == LoginStatus.success) {
              Map userData = await FacebookAuth.instance.getUserData();
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: userData['email'], token: result.accessToken!.token, uniqueId: result.accessToken!.userId, medium: 'facebook',
              ),fromPage: fromPage);
            }
          },
          child: TextHover(
            builder: (hovered){
              return Container(
                height: ResponsiveHelper.isDesktop(context)?50 :ResponsiveHelper.isTab(context)? 40:40,
                width: ResponsiveHelper.isDesktop(context)? 130 :ResponsiveHelper.isTab(context)? 110: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hovered?Theme.of(context).primaryColor.withOpacity(0.1) :Theme.of(context).shadowColor,
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.facebook,
                      height: ResponsiveHelper.isDesktop(context)?30 :ResponsiveHelper.isTab(context)? 25:20,
                      width: ResponsiveHelper.isDesktop(context)? 30 :ResponsiveHelper.isTab(context)? 25: 20,
                    ),

                    !ResponsiveHelper.isMobile(context)?
                    Row(
                      children: [
                        const SizedBox(width: Dimensions.paddingSizeSmall,),
                        Text('facebook'.tr,style: ubuntuRegular.copyWith(),)
                      ],
                    ):const SizedBox.shrink()
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    ]);
  }
}
