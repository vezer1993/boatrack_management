import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/strings.dart';
import 'package:boatrack_management/resources/text_styles.dart';
import 'package:boatrack_management/resources/values.dart';
import 'package:boatrack_management/widgets/dashboard/dashboard_calendar_widget.dart';
import 'package:flutter/material.dart';

import '../resources/box_decorations.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: CustomBoxDecorations.standardBoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(StaticValues.standardContainerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StaticStrings.getDashboardCalendarTitle(), style: CustomTextStyles.textStyleTitle(context),),
                CustomTextStyles.containerVerticalTextSeparator(),
                const DashboardCalendarWidget(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
