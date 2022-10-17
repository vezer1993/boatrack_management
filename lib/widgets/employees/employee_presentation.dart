import 'package:boatrack_management/models/cleaning.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/widgets/containers/double_widget_container.dart';
import 'package:boatrack_management/widgets/containers/multi_widget_container.dart';
import 'package:boatrack_management/widgets/employees/employee_cleaning_list.dart';
import 'package:boatrack_management/widgets/employees/sub_widgets/employee_yachts_average_time_widget.dart';
import 'package:boatrack_management/widgets/employees/sub_widgets/employee_yachts_cleaned_widget.dart';
import 'package:flutter/material.dart';

import '../../models/account.dart';
import '../../services/accounts_api.dart';

class EmployeePresentationWidget extends StatefulWidget {
  final int selectedEmployee;

  const EmployeePresentationWidget({Key? key, required this.selectedEmployee})
      : super(key: key);

  @override
  State<EmployeePresentationWidget> createState() =>
      _EmployeePresentationWidgetState();
}

class _EmployeePresentationWidgetState
    extends State<EmployeePresentationWidget> {
  late Accounts account;
  late List<Cleaning> cleanings;
  bool dataLoaded = false;

  Future getEmployee() async {
    if (!dataLoaded || widget.selectedEmployee != account.id) {
      account = await getSelectedUser(widget.selectedEmployee);
      cleanings = await getCleaningsForUser(account.id!);
      dataLoaded = true;
    }
    return account;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedEmployee == 0) {
      return const SizedBox();
    } else {
      return FutureBuilder(
          future: getEmployee(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text("NO CONNECTION");
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(account.name.toString().toUpperCase(), style: CustomTextStyles.textStyleTitle(context),),
                  const SizedBox(height: 30,),
                  MultiWidgetContainer(rightWidget: Text("hi bottom"), topLeftWidget: EmployeeYachtsCleanedWidget(cleanings: cleanings), mainWidget: EmployeeCleaningList(employeeID: widget.selectedEmployee, containerHeight: 325, cleanings: cleanings,), containerHeight: 370, topRightWidget: EmployeeAverageCleaningTimeWidget(cleanings: cleanings,),)
                ],
              );
            }
          });
    }
  }
}
