import 'package:boatrack_management/models/account.dart';
import 'package:boatrack_management/models/board_task.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/widgets/dialogs/dialog_new_board_task.dart';
import 'package:flutter/material.dart';

import '../../../helpers/conversions.dart';
import '../../../resources/styles/button_styles.dart';
import '../../../services/accounts_api.dart';

class EmployeeBoardAccountWidget extends StatefulWidget {
  final Accounts acc;

  const EmployeeBoardAccountWidget({Key? key, required this.acc})
      : super(key: key);

  @override
  State<EmployeeBoardAccountWidget> createState() =>
      _EmployeeBoardAccountWidgetState();
}

class _EmployeeBoardAccountWidgetState
    extends State<EmployeeBoardAccountWidget> {
  TextEditingController taskInputController = TextEditingController();
  late List<BoardTask> futureData;
  bool dataLoaded = false;

  Future getEmployeeList() async {
    if (!dataLoaded) {
      futureData = await getUnresolvedBoardTasks(widget.acc.id!);
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBoxDecorations.standardBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Icon(
              Icons.account_circle,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.acc.name.toString(),
            style: CustomTextStyles.textStyleTitle(context),
          ),
          FutureBuilder(
              future: getEmployeeList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("NO CONNECTION");
                } else if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: futureData.length,
                      itemBuilder: (BuildContext context, int index) {

                        Color priorityColor = Colors.green;

                        if(futureData[index].priorityLevel == "2"){
                          priorityColor = Colors.orange;
                        } else if (futureData[index].priorityLevel == "3"){
                          priorityColor = Colors.red;
                        }

                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: CustomBoxDecorations.standardBoxDecoration().copyWith(color: CustomColors().websiteBackgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 5,
                                    decoration: CustomBoxDecorations.standardBoxDecoration().copyWith(color: priorityColor),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(futureData[index].task.toString(), style: CustomTextStyles.textStyleTableColumn(context),),
                                  const SizedBox(height: 5,),
                                  Text("DEADLINE: " + Conversion.convertISOTimeToStandardFormatWithTime(futureData[index].deadline.toString()), style: CustomTextStyles.textStyleTableDescription(context),)
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
          Spacer(),
          Center(
            child: SizedBox(
              width: 150,
              height: 35,
              child: ElevatedButton(
                style: CustomButtonStyles.getStandardButtonStyle(),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogNewBoardTask(
                          acc: widget.acc,
                        );
                      });
                },
                child: Text(
                  "ADD TASK",
                  style: CustomTextStyles.getButtonTextStyle(context),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
