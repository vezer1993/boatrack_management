import 'package:flutter/material.dart';

import '../colors.dart';

class CustomButtonStyles{
  static ButtonStyle getStandardButtonStyle(){
    return ElevatedButton.styleFrom(
      primary: CustomColors().navigationTitleColor,
      padding: const EdgeInsets.fromLTRB(5, 2, 2, 5),
    );
  }
}