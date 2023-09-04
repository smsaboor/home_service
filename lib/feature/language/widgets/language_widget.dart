import 'package:lucknow_home_services/components/ripple_button.dart';
import 'package:lucknow_home_services/controller/localization_controller.dart';
import 'package:lucknow_home_services/data/model/response/language_model.dart';
import 'package:lucknow_home_services/utils/dimensions.dart';
import 'package:lucknow_home_services/utils/styles.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget({Key? key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = localizationController.isLtr ? 0 : 1;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
              color:Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: cardShadow
          ),
          child: Stack(children: [
            Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 65, width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.2), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    languageModel.imageUrl!, width: 36, height: 36,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Text(languageModel.languageName!, style: ubuntuRegular),
              ]),
            ),
            localizationController.selectedIndex == index ? Positioned(
              top: 0, right: 0,
              child: Icon(Icons.check_circle, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6), size: 25),
            ) : const SizedBox(),
          ]),
        ),
        Positioned.fill(child: RippleButton(onTap: () {
          localizationController.setSelectIndex(index);
        }))
      ],
    );
  }
}
