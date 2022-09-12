import 'package:boatrack_management/helpers/lottie/success.dart';
import 'package:flutter/material.dart';

class LottieManager{

  static showSuccessMessage(BuildContext context){
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return const DialogSuccess();
        });
  }

}