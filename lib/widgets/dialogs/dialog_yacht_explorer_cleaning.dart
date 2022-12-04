import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/models/cleaning.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/accounts_api.dart';
import 'package:flutter/material.dart';

import '../../models/account.dart';
import '../../models/yacht.dart';
import '../yachts/yacht_cleaning_list_widget.dart';

class DialogYachtExplorerCleaning extends StatefulWidget {
  final Cleaning cleaning;
  final Yacht yacht;

  const DialogYachtExplorerCleaning({Key? key, required this.cleaning, required this.yacht})
      : super(key: key);

  @override
  State<DialogYachtExplorerCleaning> createState() =>
      _DialogYachtExplorerCleaningState();
}

class _DialogYachtExplorerCleaningState
    extends State<DialogYachtExplorerCleaning> {

  Cleaning? changedCleaning;
  late Cleaning cleaning;
  late Accounts employee;
  bool dataLoaded = false;

  Future getEmployeeData() async {
    if (!dataLoaded) {
      employee = await getSelectedUser(cleaning.accountId!);
      dataLoaded = true;
    }
    return employee;
  }

  @override
  Widget build(BuildContext context) {

    if(changedCleaning == null){
      cleaning = widget.cleaning;
    }else{
      cleaning = changedCleaning!;
    }

    DateTime dtStart = Conversion.convertISOMobileStringToDateTime(cleaning.timeStarted.toString());
    DateTime dtFinish = Conversion.convertISOMobileStringToDateTime(cleaning.timeFinished.toString());

    int dtMinuteDifference = dtFinish.difference(dtStart).inMinutes;

    return FutureBuilder(
        future: getEmployeeData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CustomColors().altBackgroundColor,
                  boxShadow: [CustomBoxDecorations.containerBoxShadow()]),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CLEANING",
                      style: CustomTextStyles.textStyleTitle(context),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 1,
                                          left: 2,
                                          right: 2
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: CustomColors().primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "EMPLOYEE",
                                        style:
                                        CustomTextStyles.textStyleTableHeader(
                                            context),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        employee.name.toString(),
                                        style:
                                        CustomTextStyles.textStyleTableColumn(
                                            context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 1,
                                          left: 2,
                                          right: 2
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: CustomColors().primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "DATE",
                                        style:
                                        CustomTextStyles.textStyleTableHeader(
                                            context),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Conversion.convertISOTimeToStandardFormat(cleaning.timeFinished.toString()),
                                        style:
                                        CustomTextStyles.textStyleTableColumn(
                                            context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1, child: const SizedBox(),)
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 1,
                                        left: 2,
                                        right: 2
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: CustomColors().primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "TIME STARTED",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      Conversion.convertISOTimeToStandardFormatOnlyTime(cleaning.timeStarted.toString()),
                                      style:
                                      CustomTextStyles.textStyleTableColumn(
                                          context),
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(flex: 1, child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 1,
                                        left: 2,
                                        right: 2
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: CustomColors().primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "TIME FINISHED",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      Conversion.convertISOTimeToStandardFormatOnlyTime(cleaning.timeFinished.toString()),
                                      style:
                                      CustomTextStyles.textStyleTableColumn(
                                          context),
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(flex: 1, child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 1,
                                        left: 2,
                                        right: 2
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: CustomColors().primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "TOTAL DURATION",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      dtMinuteDifference.toString() + " min",
                                      style:
                                      CustomTextStyles.textStyleTableColumn(
                                          context),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 1,
                                left: 2,
                                right: 2
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().primaryColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "ISSUES",
                              style:
                              CustomTextStyles.textStyleTableHeader(
                                  context),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "no issues",
                              style: CustomTextStyles.textStyleTableColumn(
                                  context),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 1,
                                left: 2,
                                right: 2
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().primaryColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "OTHER CLEANINGS",
                              style:
                              CustomTextStyles.textStyleTableHeader(
                                  context),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: YachtCleaningListWidget(yacht: widget.yacht, containerHeight: 300, callback: swapExploringItem,),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
  void swapExploringItem(Cleaning c){
    setState(() {
      changedCleaning = c;
    });
  }
}
