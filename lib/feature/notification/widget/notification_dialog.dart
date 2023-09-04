import 'package:get/get.dart';
import 'package:lucknow_home_services/core/core_export.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationData? notificationModel;
  const NotificationDialog({super.key, @required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.isDarkMode?Theme.of(context).primaryColorDark:null,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
      insetPadding: const EdgeInsets.all(30),
      titlePadding:const EdgeInsets.all(0.0),
      contentPadding:const EdgeInsets.all(0.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Align(alignment: Alignment.topRight,
        child: IconButton(icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      content:  SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    notificationModel!.title!=null?Text(notificationModel!.title!,style: ubuntuMedium.copyWith(color: Theme.of(context).
                    textTheme.bodyLarge!.color!.withOpacity(0.7) ,
                        fontSize: Dimensions.fontSizeDefault
                    )): const SizedBox.shrink(),

                    SizedBox(height: notificationModel!.title!=null? Dimensions.paddingSizeDefault:0,),

                    Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            color: Theme.of(context).primaryColor.withOpacity(0.20)
                        ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''/push-notification/${notificationModel!.coverImage}',
                          fit: BoxFit.contain,
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder, height: MediaQuery.of(context).size.width - 130,
                            width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: notificationModel!.description!=null? Dimensions.paddingSizeDefault:0,),
                    notificationModel!.description!=null?Text(notificationModel!.description!,style: ubuntuRegular.copyWith(color: Theme.of(context).
                    textTheme.bodyLarge!.color!.withOpacity(0.5) ,
                      fontSize: Dimensions.fontSizeDefault,
                    ),textAlign: TextAlign.justify,):const SizedBox.shrink(),

                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
