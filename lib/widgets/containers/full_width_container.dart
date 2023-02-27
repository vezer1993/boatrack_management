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

  bool titleVisible = true;

  @override
  Widget build(BuildContext context) {

    if(widget.title == ""){
      titleVisible = false;
    }

    return Container(
      width: double.infinity,
      decoration: CustomBoxDecorations.standardBoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(StaticValues.standardContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(visible: titleVisible, child: Text(widget.title, style: CustomTextStyles.textStyleTitle(context),)),
            CustomTextStyles.containerVerticalTextSeparator(),
            widget.childWidget,
          ],
        ),
      ),
    );
  }
}
