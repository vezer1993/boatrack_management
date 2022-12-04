import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../models/cleaning.dart';

class EmployeeYachtsCleanedWidget extends StatefulWidget {
  final List<Cleaning> cleanings;

  const EmployeeYachtsCleanedWidget({Key? key, required this.cleanings})
      : super(key: key);

  @override
  State<EmployeeYachtsCleanedWidget> createState() =>
      _EmployeeYachtsCleanedWidgetState();
}

class _EmployeeYachtsCleanedWidgetState
    extends State<EmployeeYachtsCleanedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          child: Center(
            child: Text(widget.cleanings.length.toString(), style: CustomTextStyles.textStyleTitle(context),),
          ),
        ),
        Center(
          child: Text("TOTAL CLEANED", style: CustomTextStyles.textStyleTableDescription(context),),
        )
      ],
    );
  }
}
