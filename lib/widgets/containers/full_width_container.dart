import 'package:flutter/material.dart';

import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class FullWidthContainer extends StatefulWidget {

  final String title;
  final Widget childWidget;

  const FullWidthContainer({Key? key, required this.title, required this.childWidget}) : super(key: key);

  @override
  State<FullWidthContainer> createState() => _FullWidthContainerState();
}

class _FullWidthContainerState extends State<FullWidthContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: CustomBoxDecorations.standardBoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(StaticValues.standardContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: CustomTextStyles.textStyleTitle(context),),
            CustomTextStyles.containerVerticalTextSeparator(),
            widget.childWidget,
          ],
        ),
      ),
    );
  }
}
