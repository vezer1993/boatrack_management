import 'package:boatrack_management/models/yacht.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:flutter/material.dart';

import '../../models/account.dart';
import '../../models/charter.dart';
import '../../models/employeeTask.dart';
import '../../models/notification_type.dart';
import '../../resources/colors.dart';
import '../../resources/styles/button_styles.dart';
import '../../resources/styles/text_styles.dart';
import '../../services/accounts_api.dart';
import '../../services/charter_api.dart';

class EmployeeDelegateTaskWidget extends StatefulWidget {
  const EmployeeDelegateTaskWidget({Key? key}) : super(key: key);

  @override
  State<EmployeeDelegateTaskWidget> createState() =>
      _EmployeeDelegateTaskWidgetState();
}

class _EmployeeDelegateTaskWidgetState
    extends State<EmployeeDelegateTaskWidget> {
  late List<Accounts> futureData;
  List<bool> selectedAccounts = [];
  bool dataLoaded = false;
  int selectedFilter = 0;
  List<Color> filterItemBackground = [CustomColors().selectedItemColor, Colors.transparent, Colors.transparent, Colors.transparent];
  List<Accounts> filteredAccounts = [];
  bool filterAccs = true;

  List<Color> taskBackground = [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent];
  List<bool> selectedTasks = [false, false, false, false, false];
  TextEditingController taskNote = TextEditingController();
  List<Accounts> selectedAcc = [];

  late List<Yacht> yachts;
  List<bool> selectedYachtsBool = [];
  List<Yacht> selectedYachts = [];

  List<String> taskTypes = [
    NotificationEnum.cleaning,
    NotificationEnum.checkin,
    NotificationEnum.checkout,
    NotificationEnum.preparation,
    NotificationEnum.service
  ];

  bool sendingData = false;

  Future getEmployeeList() async {
    if (!dataLoaded) {
      futureData = await getUserList();
      yachts = await getYachtList();
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getEmployeeList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {

            if(filterAccs){
              filterAccounts();
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: CustomBoxDecorations.standardBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("SELECT EMPLOYEES", style: CustomTextStyles.textStyleTitle(context),),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  filterItemBackground[selectedFilter] = Colors.transparent;
                                  selectedFilter = 0;
                                  filterItemBackground[selectedFilter] = CustomColors().selectedItemColor;
                                  filterAccs = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  color: filterItemBackground[0],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("ALL", style: CustomTextStyles.textStyleTableHeader(context),),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  filterItemBackground[selectedFilter] = Colors.transparent;
                                  selectedFilter = 1;
                                  filterItemBackground[selectedFilter] = CustomColors().selectedItemColor;
                                  filterAccs = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  color: filterItemBackground[1],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("CLEANERS", style: CustomTextStyles.textStyleTableHeader(context),),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  filterItemBackground[selectedFilter] = Colors.transparent;
                                  selectedFilter = 2;
                                  filterItemBackground[selectedFilter] = CustomColors().selectedItemColor;
                                  filterAccs = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  color: filterItemBackground[2],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("SAILORS", style: CustomTextStyles.textStyleTableHeader(context),),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  filterItemBackground[selectedFilter] = Colors.transparent;
                                  selectedFilter = 3;
                                  filterItemBackground[selectedFilter] = CustomColors().selectedItemColor;
                                  filterAccs = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  color: filterItemBackground[3],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("ADMINS", style: CustomTextStyles.textStyleTableHeader(context),),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 600,
                          width: 500,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: filteredAccounts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedAccounts[index] = !selectedAccounts[index];
                                    if(selectedAccounts[index]){
                                      selectedAcc.add(filteredAccounts[index]);
                                    }else{
                                      for(Accounts acc in selectedAcc){
                                        if(acc.id == filteredAccounts[index].id){
                                          selectedAcc.remove(acc);
                                        }
                                      }
                                    }

                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: selectedAccounts[index]
                                          ? CustomColors().selectedItemColor
                                          : CustomColors().altBackgroundColor,
                                      border: Border.all(color: CustomColors().borderColor, width: 1)),
                                  child: Center(
                                      child: Text(
                                        filteredAccounts[index].name.toString(),
                                        style: CustomTextStyles.textStyleTableColumn(
                                            context)
                                            ?.copyWith(
                                            color: selectedAccounts[index]
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
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Visibility(visible: selectedAcc.isNotEmpty ,child: Container(
                  decoration: CustomBoxDecorations.standardBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("SELECT YACHTS", style: CustomTextStyles.textStyleTitle(context),),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 600,
                          width: 500,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: yachts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedYachtsBool[index] = !selectedYachtsBool[index];
                                    if(selectedYachtsBool[index]){
                                      selectedYachts.add(yachts[index]);
                                    }else{
                                      for(Yacht y in selectedYachts){
                                        if(y.id == yachts[index].id){
                                          selectedYachts.remove(y);
                                        }
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: selectedYachtsBool[index]
                                          ? CustomColors().selectedItemColor
                                          : CustomColors().altBackgroundColor,
                                      border: Border.all(color: CustomColors().borderColor, width: 1)),
                                  child: Center(
                                      child: Text(
                                        yachts[index].name.toString(),
                                        style: CustomTextStyles.textStyleTableColumn(
                                            context)
                                            ?.copyWith(
                                            color: selectedYachtsBool[index]
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
                    ),
                  ),
                ),),
                const SizedBox(width: 20,),
                Visibility(
                  visible: selectedYachts.isNotEmpty,
                  child: Container(
                    width: 900,
                    decoration: CustomBoxDecorations.standardBoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("SELECT TASK TYPE/TYPES",style: CustomTextStyles.textStyleTitle(context)),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int temp = 0;
                                    if(selectedTasks[temp]){
                                      taskBackground[temp] = Colors.transparent;
                                      selectedTasks[temp] = false;
                                    }else{
                                      taskBackground[temp] = CustomColors().selectedItemColor;
                                      selectedTasks[temp] = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: CustomColors().unSelectedItemColor),
                                    color: taskBackground[0],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(Icons.cleaning_services, size: 19, color: CustomColors().navigationIconColor,),
                                        const SizedBox(height: 7,),
                                        Text("CLEANING", style: CustomTextStyles.textStyleTableHeader(context),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int temp = 1;
                                    if(selectedTasks[temp]){
                                      taskBackground[temp] = Colors.transparent;
                                      selectedTasks[temp] = false;
                                    }else{
                                      taskBackground[temp] = CustomColors().selectedItemColor;
                                      selectedTasks[temp] = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: CustomColors().unSelectedItemColor),
                                    color: taskBackground[1],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(Icons.double_arrow_outlined, size: 19, color: CustomColors().navigationIconColor,),
                                        const SizedBox(height: 7,),
                                        Text("CHECK IN", style: CustomTextStyles.textStyleTableHeader(context),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int temp = 2;
                                    if(selectedTasks[temp]){
                                      taskBackground[temp] = Colors.transparent;
                                      selectedTasks[temp] = false;
                                    }else{
                                      taskBackground[temp] = CustomColors().selectedItemColor;
                                      selectedTasks[temp] = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: CustomColors().unSelectedItemColor),
                                    color: taskBackground[2],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(Icons.subdirectory_arrow_left_outlined, size: 19, color: CustomColors().navigationIconColor,),
                                        const SizedBox(height: 7,),
                                        Text("CHECK OUT", style: CustomTextStyles.textStyleTableHeader(context),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int temp = 3;
                                    if(selectedTasks[temp]){
                                      taskBackground[temp] = Colors.transparent;
                                      selectedTasks[temp] = false;
                                    }else{
                                      taskBackground[temp] = CustomColors().selectedItemColor;
                                      selectedTasks[temp] = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: CustomColors().unSelectedItemColor),
                                    color: taskBackground[3],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(Icons.fact_check_outlined, size: 19, color: CustomColors().navigationIconColor,),
                                        const SizedBox(height: 7,),
                                        Text("PREPARATION", style: CustomTextStyles.textStyleTableHeader(context),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    int temp = 4;
                                    if(selectedTasks[temp]){
                                      taskBackground[temp] = Colors.transparent;
                                      selectedTasks[temp] = false;
                                    }else{
                                      taskBackground[temp] = CustomColors().selectedItemColor;
                                      selectedTasks[temp] = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(color: CustomColors().unSelectedItemColor),
                                    color: taskBackground[4],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Icon(Icons.home_repair_service, size: 19, color: CustomColors().navigationIconColor,),
                                        const SizedBox(height: 7,),
                                        Text("SERVICE", style: CustomTextStyles.textStyleTableHeader(context),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Visibility(visible:taskTypeSelected() ,child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20,),
                              Text("TASK NOTE", style: CustomTextStyles.textStyleTitle(context)),
                              const SizedBox(height: 5,),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30, 0, 30, 0),
                                  child: Center(
                                    child: TextField(
                                      controller:
                                      taskNote,
                                      style: CustomTextStyles
                                          .textStyleTableColumnNoBold(
                                          context),
                                      minLines: 3,
                                      maxLines: 5,
                                      decoration: CustomBoxDecorations
                                          .getStandardInputDecoration(
                                          context, true)
                                          .copyWith(
                                          hintText:
                                          "TASK NOTE"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Center(
                                child: SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: CustomButtonStyles.getStandardButtonStyle(),
                                    onPressed: !sendingData ? () async {

                                      setState(() {
                                        sendingData = true;
                                      });
                                      for(int i = 0; i < selectedTasks.length; i++){
                                        if(selectedTasks[i]){
                                          for(Accounts acc in selectedAcc){
                                            for(Yacht yacht in selectedYachts){
                                              EmployeeTask t = EmployeeTask();
                                              t.taskName = NotificationEnum.getTaskMessage(taskTypes[i], yacht.name.toString());
                                              t.typeId = yacht.id;
                                              t.accountId = acc.id;
                                              Charter ch = await getCharter();
                                              t.charterId = ch.id;
                                              t.taskType = taskTypes[i];
                                              t.note = taskNote.text;

                                              await postNewTask(t, context);
                                            }
                                          }
                                        }
                                      }

                                      setState(() {
                                        resetDataFilter();
                                      });
                                    } : null,
                                    child: Text(
                                      "DELEGATE TASKS",
                                      style: CustomTextStyles
                                          .getButtonTextStyle(context),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                            ],
                          )),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        });
  }

  void filterAccounts() {
    resetData();
    if(selectedFilter == 0){
      for(Accounts acc in futureData){
        filteredAccounts.add(acc);
        selectedAccounts.add(false);
      }
    }else if (selectedFilter == 1){
      for(Accounts acc in futureData){
        if(acc.role == "cleaner"){
          filteredAccounts.add(acc);
          selectedAccounts.add(false);
        }
      }
    } else if (selectedFilter == 2){
      for(Accounts acc in futureData){
        if(acc.role == "sailor"){
          filteredAccounts.add(acc);
          selectedAccounts.add(false);
        }
      }
    } else if (selectedFilter == 3){
      for(Accounts acc in futureData){
        if(acc.isAdmin != null){
          if(acc.isAdmin == true){
            filteredAccounts.add(acc);
            selectedAccounts.add(false);
          }
        }
      }
    }

    filterAccs = false;
  }

  void resetData() {
    filteredAccounts = [];
    selectedAccounts = [];
    selectedAcc = [];
    taskBackground = [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent];
    selectedTasks = [false, false, false, false, false];
    taskNote = TextEditingController();

    selectedYachtsBool = [];
    selectedYachts = [];
    for(Yacht y in yachts){
      selectedYachtsBool.add(false);
    }
  }

  void resetDataFilter() {
    filteredAccounts = [];
    selectedAccounts = [];
    selectedAcc = [];
    taskBackground = [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent];
    selectedTasks = [false, false, false, false, false];
    taskNote = TextEditingController();
    filterAccs = true;
    sendingData = false;
  }

  bool taskTypeSelected() {
    for(bool b in selectedTasks){
      if(b){
        return true;
      }
    }
    return false;
  }

}
