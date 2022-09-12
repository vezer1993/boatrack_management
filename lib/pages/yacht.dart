import 'package:boatrack_management/widgets/containers/double_widget_container.dart';
import 'package:boatrack_management/widgets/containers/multi_widget_container.dart';
import 'package:boatrack_management/widgets/yachts/yacht_presentation.dart';
import 'package:flutter/material.dart';

import '../models/yacht.dart';
import '../resources/separators.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/user_interface/header.dart';
import '../widgets/yachts/yacht_information_widget.dart';

class YachtPage extends StatefulWidget {
  final Yacht yacht;
  final Function notifyParentGoPageBack;
  const YachtPage({Key? key, required this.yacht, required this.notifyParentGoPageBack}) : super(key: key);

  @override
  State<YachtPage> createState() => _YachtPageState();
}

class _YachtPageState extends State<YachtPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderWidget(previousPage: 'yachts', goPageBack: goPageBack),
            Separators.dashboardVerticalSeparator(),
            FullWidthContainer(
              title: widget.yacht.name.toString(),
              childWidget: YachtPresentationWidget(yacht: widget.yacht),
            ),
            Separators.dashboardVerticalSeparator(),
            MultiWidgetContainer(topLeftWidget: Text("hi2"), mainWidget: YachtInformationWidget(yacht: widget.yacht, containerHeight: 400), rightWidget: Text("hi3"), topRightWidget: Text("hi4"), containerHeight: 400,)
          ],
        ),
      ),
    );
  }

  void goPageBack(String page){
    widget.notifyParentGoPageBack(page);
  }
}
