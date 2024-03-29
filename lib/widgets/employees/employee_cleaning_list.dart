import 'package:flutter/material.dart';

import '../../helpers/conversions.dart';
import '../../models/cleaning.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class EmployeeCleaningList extends StatefulWidget {
  final int employeeID;
  final double containerHeight;
  final List<Cleaning> cleanings;
  const EmployeeCleaningList({Key? key, required this.employeeID, required this.containerHeight, required this.cleanings}) : super(key: key);

  @override
  State<EmployeeCleaningList> createState() => _EmployeeCleaningListState();
}

class _EmployeeCleaningListState extends State<EmployeeCleaningList> {

  double pageSelectionHeight = 50;
  double columnWidth = 130;
  double columnHeight = 37;

  int itemsPerPage = 4;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    int pageCount = (widget.cleanings.length / 4).ceil();

    return SizedBox(
        height: widget.containerHeight,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: columnWidth * 6,
                height: widget.containerHeight - pageSelectionHeight,
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
                                      child: Text("STARTED",
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
                                      child: Text("FINISHED",
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
                                      child: Text("ISSUES",
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
                          widget.cleanings.length) {
                        int i = index + ((page - 1) * itemsPerPage);

                        Cleaning b = widget.cleanings[i];

                        String dateStarted = Conversion.convertISOTimeToStandardFormatWithTime(
                            b.timeStarted.toString());
                        String dateFinished = Conversion.convertISOTimeToStandardFormatWithTime(
                            b.timeFinished.toString());

                        return Container(
                          width: columnWidth * 5,
                          height: (widget.containerHeight -
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
                                      child: Text(dateStarted,
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
                                    child: Text(dateFinished,
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
                                        b.employee.toString(),
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
                                      child: Text(b.hasIssues.toString(),
                                          style: CustomTextStyles
                                              .textStyleTableColumn(
                                              context))),
                                ),
                              )
                            ],
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
}
