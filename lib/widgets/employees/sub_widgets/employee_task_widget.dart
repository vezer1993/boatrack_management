import 'package:boatrack_management/models/employeeTask.dart';
import 'package:boatrack_management/models/notification_type.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/accounts_api.dart';
import 'package:boatrack_management/services/charter_api.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:flutter/material.dart';

import '../../../models/account.dart';
import '../../../models/charter.dart';
import '../../../models/yacht.dart';
import '../../../resources/styles/button_styles.dart';

class EmployeeTaskWidget extends StatefulWidget {
  final Accounts account;

  const EmployeeTaskWidget({Key? key, required this.account}) : super(key: key);

  @override
  State<EmployeeTaskWidget> createState() => _EmployeeTaskWidgetState();
}

class _EmployeeTaskWidgetState extends State<EmployeeTaskWidget> {
  bool dataLoaded = false;
  late List<Yacht> yachts;
  List<bool> yachtsSelected = [];

  TextEditingController resolveNoteEditingController = TextEditingController();

  Future getFutureData() async {
    if (!dataLoaded) {
      yachts = await getYachtList(false);
      yachtsSelected = [];
      for(Yacht y in yachts){
        yachtsSelected.add(false);
      }
      dataLoaded = true;
    }
    return yachts;
  }

  List<String> taskTypes = [
    NotificationEnum.cleaning,
    NotificationEnum.checkin,
    NotificationEnum.checkout,
    NotificationEnum.preCheckin,
    NotificationEnum.postCheckout,
    NotificationEnum.service,
  ];
  List<bool> selectedTypes = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "DELEGATE TASK",
            style: CustomTextStyles.textStyleTitle(context),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TASK TYPE",
                        style: CustomTextStyles.textStyleTableHeader(context),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: taskTypes.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTypes[index] = !selectedTypes[index];
                                });
                              },
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: selectedTypes[index]
                                        ? CustomColors().selectedItemColor
                                        : CustomColors().altBackgroundColor,
                                    border: Border.all(color: CustomColors().borderColor, width: 1)),
                                child: Center(
                                    child: Text(
                                  taskTypes[index],
                                  style: CustomTextStyles.textStyleTableColumn(
                                          context)
                                      ?.copyWith(
                                          color: selectedTypes[index]
                                              ? CustomColors().primaryColor
                                              : CustomColors()
                                                  .navigationTextColor),
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: oneTypeSelected(),
                    child: FutureBuilder(
                      future: getFutureData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return const Text("NO CONNECTION");
                        } else if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "YACHT",
                                style: CustomTextStyles.textStyleTableHeader(context),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          width: 1, color: CustomColors().borderColor),
                                      right: BorderSide(
                                          width: 1, color: CustomColors().borderColor)),
                                ),
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: yachts.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            yachtsSelected[index] = !yachtsSelected[index];
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: yachtsSelected[index]
                                                  ? CustomColors().selectedItemColor
                                                  : CustomColors().altBackgroundColor,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: CustomColors().borderColor),
                                                  top: BorderSide(
                                                      width: 1,
                                                      color:
                                                      CustomColors().borderColor))),
                                          child: Center(
                                              child: Text(
                                                yachts[index].name.toString(),
                                                style: CustomTextStyles.textStyleTableColumn(
                                                    context)
                                                    ?.copyWith(
                                                    color: yachtsSelected[index]
                                                        ? CustomColors().primaryColor
                                                        : CustomColors()
                                                        .navigationTextColor),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ))
            ],
          ),
          const SizedBox(height: 10,),
          Center(
            child: SizedBox(
              width: 125,
              child: ElevatedButton(
                onPressed: buttonEnabled() ? () async {
                  for(int i = 0; i < selectedTypes.length; i++){
                    if(selectedTypes[i]){
                      for(int x = 0; x < yachtsSelected.length; x++){
                        if(yachtsSelected[x]){
                          EmployeeTask t = EmployeeTask();
                          t.taskName = NotificationEnum.getTaskMessage(taskTypes[i], yachts[x].name.toString());
                          t.typeId = yachts[x].id;
                          t.accountId = widget.account.id;
                          Charter ch = await getCharter();
                          t.charterId = ch.id;
                          t.taskType = taskTypes[i];

                          await postNewTask(t, context);
                        }
                      }
                    }
                  }
                  setState(() {
                    resetControls();
                  });
                } : null,
                style: CustomButtonStyles
                    .getStandardButtonStyle(),
                child: Text(
                  "SUBMIT",
                  style: CustomTextStyles
                      .getButtonTextStyle(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool oneTypeSelected() {
    for (bool b in selectedTypes) {
      if (b) {
        return true;
      }
    }
    return false;
  }

  bool oneYachtSelected(){
    for(bool b in yachtsSelected){
      if(b){
        return true;
      }
    }
    return false;
  }

  bool buttonEnabled(){
    if(oneTypeSelected() && oneYachtSelected()){
      return true;
    }else{
      return false;
    }
  }

  void resetControls(){
    for(int i = 0; i < selectedTypes.length; i++){
      selectedTypes[i] = false;
    }

    for(int i = 0; i < yachtsSelected.length; i++){
      yachtsSelected[i] = false;
    }
  }
}
