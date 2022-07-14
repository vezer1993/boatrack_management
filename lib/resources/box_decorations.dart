import 'package:flutter/material.dart';

import 'colors.dart';

class CustomBoxDecorations{

  static BoxDecoration standardBoxDecoration(){
    return BoxDecoration(
      color: CustomColors().altBackgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    );
  }

  static BoxShadow containerBoxShadow(){
    return BoxShadow(
        color: CustomColors().websiteShadowColor,
        spreadRadius: 0.5,
        blurRadius: 3
    );
  }
}