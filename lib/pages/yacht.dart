import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/widgets/containers/double_widget_container.dart';
import 'package:boatrack_management/widgets/containers/multi_widget_container.dart';
import 'package:boatrack_management/widgets/yachts/sub_widgets/yacht_engine_temperature.dart';
import 'package:boatrack_management/widgets/yachts/yacht_presentation.dart';
import 'package:flutter/material.dart';

import '../models/yacht.dart';
import '../resources/separators.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/user_interface/header.dart';
import '../widgets/yachts/sub_widgets/yacht_data_used.dart';
import '../widgets/yachts/yacht_information_widget.dart';
import '../widgets/yachts/yacht_model_select_widget.dart';

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
            MultiWidgetContainer(topLeftWidget: const YachtDataUsedWidget(), mainWidget: YachtInformationWidget(yacht: widget.yacht, containerHeight: 600), rightWidget: Column(mainAxisAlignment: MainAxisAlignment.center, children: [YachtModelSelectWidget(yacht: widget.yacht, type: 'checkin/out',), const SizedBox(height: 5,), Container(width: double.infinity, height: 2, color: CustomColors().unSelectedItemColor,), const SizedBox(height: 5,),  YachtModelSelectWidget(yacht: widget.yacht, type: "pre-checkin",), const SizedBox(height: 5,), Container(width: double.infinity, height: 2, color: CustomColors().unSelectedItemColor,), const SizedBox(height: 5,),  YachtModelSelectWidget(yacht: widget.yacht, type: "post-checkin",)],), topRightWidget: YachtEngineTemperature(), containerHeight: 600,)
          ],
        ),
      ),
    );
  }

  void goPageBack(String page){
    widget.notifyParentGoPageBack(page);
  }
}
