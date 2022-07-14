import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTextStyles{

  static TextStyle? textStyleCharterName(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
      fontSize: 24,
      color: CustomColors().navigationTitleColor,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle? textStyleTitle(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 18,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle? textStyleCalendarHeaders(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 14,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w600
    );
  }

  static SizedBox containerVerticalTextSeparator(){
    return const SizedBox(height: 7,);
  }
}