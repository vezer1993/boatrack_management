import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/models/account.dart';
import 'package:boatrack_management/models/employeeTask.dart';
import 'package:boatrack_management/services/accounts_api.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:flutter/material.dart';

import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class EmployeeTaskListWidget extends StatefulWidget {
  const EmployeeTaskListWidget({Key? key}) : super(key: key);

  @override
  State<EmployeeTaskListWidget> createState() => _EmployeeTaskListWidgetState();
}

class _EmployeeTaskListWidgetState extends State<EmployeeTaskListWidget> {

  double pageSelectionHeight = 50;
  double columnWidth = 130;
  double columnHeight = 37;
  double containerHeight = 400;

  int itemsPerPage = 5;
  int page = 1;

  bool dataLoaded = false;
  List<EmployeeTask> data = [];
  List<Yacht> yachts  = [];
  List<Accounts> employees = [];

  Future getIssuesForYacht() async {
    if (!dataLoaded) {
      data = await getUnresolvedTasks();
      yachts = await getYachtListALL();
      employees = await getUserList();
      dataLoaded = true;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIssuesForYacht(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (data.isEmpty) {
              return SizedBox(
                height: containerHeight,
                child: Center(
                  child: Text(
                    "Currently no data",
                    style: CustomTextStyles.textStyleTitle(context),
                  ),
                ),
              );
            }

            int pageCount = (data.length / itemsPerPage).ceil();

            return SizedBox(
                height: containerHeight,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: columnWidth * 6,
                        height: containerHeight - pageSelectionHeight,
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemsPerPage + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                // return the header
                                return Container(
                                  height: columnHeight,
                                  width: columnWidth * 5,
                                  decoration: CustomBoxDecorations
                                      .tableHeaderContainer(),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("ASSIGNED",
                                                  style: CustomTextStyles
                                                      .textStyleTableHeader(
                                                      context))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("TASK TYPE",
                                                  style: CustomTextStyles
                                                      .textStyleTableHeader(
                                                      context))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 2,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text(
                                                "EMPLOYEE",
                                                style: CustomTextStyles
                                                    .textStyleTableHeader(context),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("YACHT",
                                                  style: CustomTextStyles
                                                      .textStyleTableHeader(
                                                      context))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              index -= 1;

                              if ((index + ((page - 1) * itemsPerPage)) <
                                  data.length) {
                                int i = index + ((page - 1) * itemsPerPage);

                                EmployeeTask task = data[i];
                                
                                Accounts employee = employees.where((element) => element.id == task.accountId).first;
                                Yacht yacht = yachts.where((element) => element.id == task.typeId).first;

                                return InkWell(
                                  child: Container(
                                    width: columnWidth * 5,
                                    height: (containerHeight -
                                        columnHeight -
                                        pageSelectionHeight) /
                                        itemsPerPage,
                                    decoration:
                                    CustomBoxDecorations.topAndBottomBorder(),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: columnWidth,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                                child: Text(Conversion.convertISOTimeToStandardFormatWithTime(task.timeCreated.toString()),
                                                    style: CustomTextStyles
                                                        .textStyleTableColumn(
                                                        context))),
                                          ),
                                        ),
                                        SizedBox(
                                          width: columnWidth,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                              child: Text(task.taskType.toString(),
                                                  style: CustomTextStyles
                                                      .textStyleTableColumn(
                                                      context)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: columnWidth * 2,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                                child: Text(
                                                  employee.name.toString(),
                                                  style: CustomTextStyles
                                                      .textStyleTableColumn(context),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: columnWidth,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                                child: Text(yacht.name.toString(),
                                                    style: CustomTextStyles
                                                        .textStyleTableColumn(
                                                        context))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                        height: pageSelectionHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (page != 1) {
                                    setState(() {
                                      page--;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.chevron_left),
                                color: CustomColors().navigationIconColor),
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: pageCount,
                                itemBuilder: (BuildContext context, int index) {
                                  int number = index + 1;

                                  Color textColor =
                                      CustomColors().unSelectedItemColor;

                                  if (page == number) {
                                    textColor =
                                        CustomColors().navigationTitleColor;
                                  }

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        page = number;
                                      });
                                    },
                                    child: Container(
                                      height: pageSelectionHeight,
                                      width: pageSelectionHeight,
                                      child: Center(
                                          child: Text(
                                            number.toString(),
                                            style: CustomTextStyles
                                                .textStyleTableColumn(context)
                                                ?.copyWith(color: textColor),
                                          )),
                                    ),
                                  );
                                }),
                            IconButton(
                                onPressed: () {
                                  if (page != pageCount) {
                                    setState(() {
                                      page++;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: CustomColors().navigationIconColor,
                                ))
                          ],
                        ))
                  ],
                ));
          }
        });
  }
}
