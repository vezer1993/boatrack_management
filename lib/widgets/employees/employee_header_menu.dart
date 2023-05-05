import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';
import 'employee_board.dart';
import 'employee_delegate_task.dart';

class EmployeeHeader extends StatefulWidget {
  final Function notifyParent;
  const EmployeeHeader({Key? key, required this.notifyParent,}) : super(key: key);

  @override
  State<EmployeeHeader> createState() => _EmployeeHeaderState();
}

class _EmployeeHeaderState extends State<EmployeeHeader> {

  List<Color> menuItemBackgrounds = [CustomColors().selectedItemColor, Colors.transparent, Colors.transparent];
  int selectedItem = 0;


  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: CustomBoxDecorations.standardBoxDecoration(),
      child: Padding(
          padding: EdgeInsets.all(StaticValues.standardContainerPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    menuItemBackgrounds[selectedItem] = Colors.transparent;
                    selectedItem = 0;
                    menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  });
                  widget.notifyParent(EmployeeBoardWidget());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[0],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("EMPLOYEES", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  menuItemBackgrounds[selectedItem] = Colors.transparent;
                  selectedItem = 1;
                  menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  widget.notifyParent(const Text("HI 2"));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[1],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("ACTIVE TASKS", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  menuItemBackgrounds[selectedItem] = Colors.transparent;
                  selectedItem = 2;
                  menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  widget.notifyParent(const EmployeeDelegateTaskWidget());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[2],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("DELEGATE", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
