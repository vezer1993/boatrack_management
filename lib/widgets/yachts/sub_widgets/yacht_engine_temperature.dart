import 'package:flutter/material.dart';

import '../../../resources/styles/text_styles.dart';

class YachtEngineTemperature extends StatefulWidget {
  const YachtEngineTemperature({Key? key}) : super(key: key);

  @override
  State<YachtEngineTemperature> createState() => _YachtEngineTemperatureState();
}

class _YachtEngineTemperatureState extends State<YachtEngineTemperature> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          child: Center(
            child: Text("ENGINE OFF", style: CustomTextStyles.textStyleTitle(context),),
          ),
        ),
        Center(
          child: Text("ENGINE TEMPERATURE", style: CustomTextStyles.textStyleTableDescription(context),),
        )
      ],
    );
  }
}
