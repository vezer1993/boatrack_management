import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../colors.dart';

class CustomBoxDecorations {
  static BoxDecoration standardBoxDecoration() {
    return BoxDecoration(
      color: CustomColors().altBackgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    );
  }

  static BoxDecoration topAndBottomBorder() {
    return BoxDecoration(
        color: CustomColors().altBackgroundColor,
        border: Border(
          top: BorderSide(width: 0.5, color: CustomColors().borderColor),
          bottom: BorderSide(width: 0.5, color: CustomColors().borderColor),
        ));
  }

  static BoxDecoration bottomBorder() {
    return BoxDecoration(
        color: CustomColors().altBackgroundColor,
        border: Border(
          bottom: BorderSide(width: 0.5, color: CustomColors().borderColor),
        ));
  }

  static BoxDecoration leftAndRightBorder() {
    return BoxDecoration(
        color: CustomColors().altBackgroundColor,
        border: Border(
          left: BorderSide(width: 0.5, color: CustomColors().borderColor),
          right: BorderSide(width: 0.5, color: CustomColors().borderColor),
        ));
  }

  static BoxShadow containerBoxShadow() {
    return BoxShadow(
        color: CustomColors().websiteShadowColor,
        spreadRadius: 0.5,
        blurRadius: 3);
  }

  static BoxDecoration tableHeaderContainer() {
    return BoxDecoration(
      color: CustomColors().tableHeaderColor,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    );
  }

  static Container getTableCheckSymbol(double height) {
    return Container(
      height: height - 32,
      width: height - 32,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          color: CustomColors().successBoxBackgroundColor),
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.check,
          color: CustomColors().successBoxCheckMarkColor,
        ),
      ),
    );
  }

  static Container getTableFailSymbol(double height) {
    return Container(
      height: height - 32,
      width: height - 32,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          color: CustomColors().failBoxBackgroundColor),
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.x,
          color: CustomColors().failBoxCheckMarkColor,
        ),
      ),
    );
  }

  static InputDecoration getStandardInputDecoration(BuildContext context, bool enalbed){
    return InputDecoration(
      isDense: true,
      contentPadding:
      const EdgeInsets.fromLTRB(5, 10, 5, 10),
      filled: enalbed,
      fillColor: CustomColors().tableHeaderColor,
      hintStyle: CustomTextStyles.textStyleTableDescription(context),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: CustomColors()
                .navigationTitleColor,
            width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: CustomColors()
                .inputBorderNotFocusedColor,
            width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: CustomColors()
                .inputBorderNotFocusedColor,
            width: 1,),
      ),
    );
  }

  static InputDecoration getLoginInputDecoration(BuildContext context, bool enalbed){
    return InputDecoration(
      isDense: true,
      contentPadding:
      const EdgeInsets.fromLTRB(25, 15, 25, 15),
      filled: enalbed,
      fillColor: CustomColors().tableHeaderColor,
      hintStyle: CustomTextStyles.textStyleTableDescription(context),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: CustomColors()
                .navigationTitleColor,
            width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: CustomColors()
                .inputBorderNotFocusedColor,
            width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors()
              .inputBorderNotFocusedColor,
          width: 1,),
      ),
    );
  }
}
