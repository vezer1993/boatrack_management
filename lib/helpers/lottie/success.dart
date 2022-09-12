import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogSuccess extends StatefulWidget {
  const DialogSuccess({Key? key,}) : super(key: key);

  @override
  State<DialogSuccess> createState() => _DialogSuccessState();
}

class _DialogSuccessState extends State<DialogSuccess>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), (){
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = 150;
    double height = 150;

    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 800) {
      width = screenSize.width / 1.2;
      height = screenSize.width / 1.2;
    }

    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
            width: width,
            height: height,
            child: Lottie.asset("assets/lottie/lottie_success.json",animate: true, frameRate: FrameRate.max,repeat: false, fit: BoxFit.cover)
        ));
  }
}