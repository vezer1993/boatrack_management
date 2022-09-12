import 'package:boatrack_management/helpers/calendar_calculations.dart';
import 'package:boatrack_management/models/yacht.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/strings.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/resources/values.dart';
import 'package:flutter/material.dart';

import '../../helpers/conversions.dart';

class DashboardYachtListWidget extends StatefulWidget {
  final List<Yacht> yachts;
  final Function notifyParent;

  const DashboardYachtListWidget({Key? key, required this.yachts, required this.notifyParent})
      : super(key: key);

  @override
  State<DashboardYachtListWidget> createState() =>
      _DashboardYachtListWidgetState();
}

class _DashboardYachtListWidgetState extends State<DashboardYachtListWidget> {
  ///Measures
  double headerHeight = StaticValues.halfContainerTableHeaderHeight;
  double columnWidth = StaticValues.halfContainerTableColumnWidth;
  double firstColumnWidth = StaticValues.halfContainerTableFirstColumnWidth;
  double columnHeight = StaticValues.halfContainerTableColumnHeight;
  double itemCount = 4;

  @override
  Widget build(BuildContext context) {
    ///CALCULATIONS
    double containerWidth = (itemCount * columnWidth) + firstColumnWidth;
    double containerHeight =
        (widget.yachts.length * columnHeight) + headerHeight;
    double imageHeight = columnHeight - 12;
    double imageWidth = firstColumnWidth / 3;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: containerHeight,
        width: containerWidth,
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.yachts == null ? 1 : widget.yachts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                // return the header
                return Container(
                    width: containerWidth,
                    height: headerHeight,
                    decoration: CustomBoxDecorations.tableHeaderContainer(),
                    child: Row(
                      children: [
                        SizedBox(
                            width: firstColumnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("YACHT",
                                      style:
                                          CustomTextStyles.textStyleTableHeader(
                                              context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("WEEKS OUT",
                                      style:
                                          CustomTextStyles.textStyleTableHeader(
                                              context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("REVENUE",
                                      style:
                                          CustomTextStyles.textStyleTableHeader(
                                              context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("THIS WEEK",
                                      style:
                                          CustomTextStyles.textStyleTableHeader(
                                              context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("NEXT WEEK",
                                      style:
                                          CustomTextStyles.textStyleTableHeader(
                                              context))),
                            )),
                      ],
                    ));
              }
              index -= 1;

              ///CALCULATE THIS AND NEXT WEEK
              int thisWeek =
                  CalendarCalculations().getWeekNumberForDate(DateTime.now());
              int nextWeek = thisWeek + 1;

              String thisWeekAvailability =
                  widget.yachts[index].availabilityForWeek(thisWeek);
              String nextWeekAvailability =
                  widget.yachts[index].availabilityForWeek(nextWeek);

              Text thisWeekTextWidget =
                  createTextAccordingToAvailability(thisWeekAvailability);
              Text nextWeekTextWidget =
                  createTextAccordingToAvailability(nextWeekAvailability);

              return InkWell(
                onTap: () {
                  widget.notifyParent(widget.yachts[index]);
                },
                child: Container(
                  width: containerWidth,
                  height: columnHeight,
                  decoration: CustomBoxDecorations.topAndBottomBorder(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: firstColumnWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: firstColumnWidth - imageWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(widget.yachts[index].name.toString(),
                                      style:
                                          CustomTextStyles.textStyleTableHeader(
                                              context)),
                                  Text(widget.yachts[index].model.toString(),
                                      style: CustomTextStyles
                                          .textStyleTableDescription(context)),
                                  Text(widget.yachts[index].year.toString(),
                                      style: CustomTextStyles
                                          .textStyleTableDescription(context)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: columnWidth,
                        child: Center(
                          child: Text(
                            widget.yachts[index].getWeeksOut().toString(),
                            style: CustomTextStyles.textStyleTableColumn(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: columnWidth,
                        child: Center(
                          child: Text(
                            Conversion.priceConversion(
                                    widget.yachts[index].getTotalRevenue()) +
                                " €",
                            style: CustomTextStyles.textStyleTableColumn(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: columnWidth,
                        child: Center(
                          child: thisWeekTextWidget,
                        ),
                      ),
                      SizedBox(
                        width: columnWidth,
                        child: Center(
                          child: nextWeekTextWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Text createTextAccordingToAvailability(String availability) {
    if (availability == "1") {
      return Text(
        StaticStrings.getTableYachtOut(),
        style: CustomTextStyles.textStyleTableYachtStatusColumn(
            context, CustomColors().calendarOutColor),
      );
    } else if (availability == "0") {
      return Text(
        StaticStrings.getTableYachtHome(),
        style: CustomTextStyles.textStyleTableYachtStatusColumn(
            context, CustomColors().calendarHomeColor),
      );
    } else {
      return Text(
        StaticStrings.getTableYachtOption(),
        style: CustomTextStyles.textStyleTableYachtStatusColumn(
            context, CustomColors().calendarOptionColor),
      );
    }
  }
}
