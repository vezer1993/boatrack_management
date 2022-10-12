import 'package:boatrack_management/widgets/employees/employee_list.dart';
import 'package:boatrack_management/widgets/employees/employee_presentation.dart';
import 'package:flutter/material.dart';

import '../resources/separators.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/user_interface/header.dart';

class EmployeePage extends StatefulWidget {
  int selectedEmployee;
  EmployeePage({Key? key, required this.selectedEmployee}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeaderWidget(previousPage: '',),
            Separators.dashboardVerticalSeparator(),
            FullWidthContainer(
              title: "EMPLOYEES",
              childWidget: EmployeeListWidget(selectedEmployee: widget.selectedEmployee, notifyParent: selectEmployee,),
            ),
            Separators.dashboardVerticalSeparator(),
            EmployeePresentationWidget(selectedEmployee: widget.selectedEmployee),
            Separators.dashboardVerticalSeparator(),
          ],
        ),
      ),
    );
  }

  void selectEmployee(int id){
    setState(() {
      widget.selectedEmployee = id;
    });
  }
}
