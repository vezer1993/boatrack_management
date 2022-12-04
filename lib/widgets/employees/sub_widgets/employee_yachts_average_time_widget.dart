import 'package:boatrack_management/helpers/conversions.dart';
import 'package:flutter/material.dart';

import '../../../models/cleaning.dart';
import '../../../resources/styles/text_styles.dart';

class EmployeeAverageCleaningTimeWidget extends StatefulWidget {
  final List<Cleaning> cleanings;
  const EmployeeAverageCleaningTimeWidget({Key? key, required this.cleanings}) : super(key: key);

  @override
  State<EmployeeAverageCleaningTimeWidget> createState() => _EmployeeAverageCleaningTimeWidgetState();
}

class _EmployeeAverageCleaningTimeWidgetState extends State<EmployeeAverageCleaningTimeWidget> {
  @override
  Widget build(BuildContext context) {

    double averageTime = 0;
    double addedUp = 0;

    for(Cleaning c in widget.cleanings){
      DateTime finish = Conversion.convertISOMobileStringToDateTime(c.timeFinished.toString());
      DateTime start = Conversion.convertISOMobileStringToDateTime(c.timeStarted.toString());
      averageTime = averageTime + finish.difference(start).inMinutes;
      addedUp++;
    }

    averageTime = averageTime / addedUp;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          child: Center(
            child: Text(averageTime.toString(), style: CustomTextStyles.textStyleTitle(context),),
          ),
        ),
        Center(
          child: Text("AVERAGE TIME", style: CustomTextStyles.textStyleTableDescription(context),),
        )
      ],
    );
  }
}
