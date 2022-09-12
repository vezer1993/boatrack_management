import 'package:boatrack_management/resources/separators.dart';
import 'package:flutter/material.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class DoubleWidgetContainer extends StatefulWidget {
  final String title1;
  final Widget widget1;
  final String title2;
  final Widget widget2;

  const DoubleWidgetContainer(
      {Key? key,
      required this.title1,
      required this.widget1,
      required this.title2,
      required this.widget2})
      : super(key: key);

  @override
  State<DoubleWidgetContainer> createState() => _DoubleWidgetContainerState();
}

class _DoubleWidgetContainerState extends State<DoubleWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > StaticValues.doubleWidgetBreakLimit) {
      return Row(
        children: [
          Expanded(
              child: Container(
            decoration: CustomBoxDecorations.standardBoxDecoration(),
            child: Padding(
              padding: EdgeInsets.all(StaticValues.standardContainerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title1,
                    style: CustomTextStyles.textStyleTitle(context),
                  ),
                  CustomTextStyles.containerVerticalTextSeparator(),
                  widget.widget1,
                ],
              ),
            ),
          )),
          Separators.dashboardHorizontalSeparator(),
          Expanded(
              child: Container(
            decoration: CustomBoxDecorations.standardBoxDecoration(),
            child: Padding(
              padding: EdgeInsets.all(StaticValues.standardContainerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title2,
                    style: CustomTextStyles.textStyleTitle(context),
                  ),
                  CustomTextStyles.containerVerticalTextSeparator(),
                  widget.widget2,
                ],
              ),
            ),
          )),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            decoration: CustomBoxDecorations.standardBoxDecoration(),
            child: Padding(
              padding: EdgeInsets.all(StaticValues.standardContainerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title1,
                    style: CustomTextStyles.textStyleTitle(context),
                  ),
                  CustomTextStyles.containerVerticalTextSeparator(),
                  widget.widget1,
                ],
              ),
            ),
          ),
          Separators.dashboardVerticalSeparator(),
          Container(
            decoration: CustomBoxDecorations.standardBoxDecoration(),
            child: Padding(
              padding: EdgeInsets.all(StaticValues.standardContainerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title2,
                    style: CustomTextStyles.textStyleTitle(context),
                  ),
                  CustomTextStyles.containerVerticalTextSeparator(),
                  widget.widget2,
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
