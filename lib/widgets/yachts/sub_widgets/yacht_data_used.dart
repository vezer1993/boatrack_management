import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../models/cleaning.dart';

class YachtDataUsedWidget extends StatefulWidget {

  const YachtDataUsedWidget({Key? key})
      : super(key: key);

  @override
  State<YachtDataUsedWidget> createState() =>
      _YachtDataUsedWidgetState();
}

class _YachtDataUsedWidgetState
    extends State<YachtDataUsedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          child: Center(
            child: Text("2.5 GB", style: CustomTextStyles.textStyleTitle(context),),
          ),
        ),
        Center(
          child: Text("DATA USED THIS WEEK", style: CustomTextStyles.textStyleTableDescription(context),),
        )
      ],
    );
  }
}
