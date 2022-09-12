import 'dart:html';

import 'package:flutter/material.dart';

import '../../resources/separators.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/values.dart';

class MultiWidgetContainer extends StatefulWidget {
  final Widget mainWidget;
  final Widget topLeftWidget;
  final Widget topRightWidget;
  final Widget rightWidget;

  final double containerHeight;

  const MultiWidgetContainer({Key? key, required this.mainWidget, required this.topLeftWidget, required this.topRightWidget, required this.rightWidget, required this.containerHeight}) : super(key: key);

  @override
  State<MultiWidgetContainer> createState() => _MultiWidgetContainerState();
}

class _MultiWidgetContainerState extends State<MultiWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double smallContainerDimension = (widget.containerHeight / 2) - (Separators.dashboardVerticalSeparator().height!/2);
    double rightContainerHeight = smallContainerDimension;

    if(MediaQuery.of(context).size.width < 1300){
      double difference = 1300 - MediaQuery.of(context).size.width;
      smallContainerDimension = smallContainerDimension - (difference / 4);
    }
    if (width > StaticValues.doubleWidgetBreakLimit) {
      return Row(
        children: [
          Expanded(
            flex: 3,
              child: Container(
                height: widget.containerHeight,
                decoration: CustomBoxDecorations.standardBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(StaticValues.standardContainerPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.mainWidget,
                    ],
                  ),
                ),
              )),
          Separators.dashboardHorizontalSeparator(),
          Expanded(
            flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: smallContainerDimension,
                        width: smallContainerDimension,
                        decoration: CustomBoxDecorations.standardBoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(StaticValues.standardContainerPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.topLeftWidget,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: smallContainerDimension,
                        width: smallContainerDimension,
                        decoration: CustomBoxDecorations.standardBoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(StaticValues.standardContainerPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.topRightWidget,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Separators.dashboardVerticalSeparator(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: rightContainerHeight,
                          decoration: CustomBoxDecorations.standardBoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(StaticValues.standardContainerPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.rightWidget,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),
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
                  widget.mainWidget
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
                  widget.rightWidget
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
