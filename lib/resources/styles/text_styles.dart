import 'package:flutter/material.dart';

import '../colors.dart';

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
        fontSize: 22,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle? textStyleCalendarHeaders(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 14,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w600,
      letterSpacing: 0.5
    );
  }

  static TextStyle? textStyleTableHeader(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 11,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5
    );
  }

  static TextStyle? textStyleTableDescription(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 9,
        color: CustomColors().descriptionTextColor,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5
    );
  }

  static TextStyle? textStyleTableColumn(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 13,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5
    );
  }

  static TextStyle? textStyleTableColumnNoBold(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 13,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w400,
    );
  }

  static TextStyle? textStyleTableYachtStatusColumn(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 13,
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5
    );
  }

  static TextStyle? tooltipTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 14,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w400,
    );
  }

  static TextStyle? getButtonTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
      fontSize: 15,
      color: CustomColors().buttonTextColor,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5
    );
  }

  static TextStyle? getUIMenuTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline1?.copyWith(
        fontSize: 15,
        color: CustomColors().navigationTextColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5
    );
  }


  static SizedBox containerVerticalTextSeparator(){
    return const SizedBox(height: 14,);
  }
}