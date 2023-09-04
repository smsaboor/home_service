import 'package:flutter/material.dart';
import 'package:lucknow_home_services/utils/styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isActive;
  const CustomText({Key? key,required this.text,required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(text,style: ubuntuMedium.copyWith(
            color: isActive ?Theme.of(context).textTheme.bodyLarge!.color:Theme.of(context).hintColor),),
      ),
    );
  }
}
