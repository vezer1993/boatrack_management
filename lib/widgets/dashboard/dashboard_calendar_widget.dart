import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/widgets/dashboard/dashboard_calendar_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helpers/calendar_calculations.dart';
import '../../models/yacht.dart';
import '../../resources/strings.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class DashboardCalendarWidget extends StatefulWidget {
  //variables
  final List<Yacht> yachts;

  const DashboardCalendarWidget({Key? key, required this.yachts})
      : super(key: key);

  @override
  State<DashboardCalendarWidget> createState() =>
      _DashboardCalendarWidgetState();
}

class _DashboardCalendarWidgetState extends State<DashboardCalendarWidget> {
  //controllers
  final ScrollController _scrollController = ScrollController();

  //variables
  List<String> weeks = CalendarCalculations().calculateBookingWeeks(DateTime.now().year);

  bool thisYearSelected = true;

  //measurements
  double tableWidth = 140;
  double headerHeight = 30;
  double rowHeight = 40;

  @override
  void initState() {
    super.initState();

    //jumpto ide za WIDTH pixela (70) je jedan
    if(thisYearSelected){
      double jumpPosition =
          (CalendarCalculations().getTodayWeekNumber() - 1) * tableWidth;
      WidgetsBinding.instance
          ?.addPostFrameCallback((_) => _scrollController.jumpTo(jumpPosition));
    }else{
      WidgetsBinding.instance
          ?.addPostFrameCallback((_) => _scrollController.jumpTo(0));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = (rowHeight * widget.yachts.length) + headerHeight;


    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: () {
                  setState(() {
                    thisYearSelected = true;
                    double jumpPosition =
                        (CalendarCalculations().getTodayWeekNumber() - 1) * tableWidth;
                    _scrollController.jumpTo(jumpPosition);
                  });
                },
                child: Text(DateTime.now().year.toString(), style: thisYearSelected ? CustomTextStyles.textStyleTitle(context)!.copyWith(color: CustomColors().primaryColor) : CustomTextStyles.textStyleTitle(context)!.copyWith(color: CustomColors().descriptionTextColor),),
              ),
            ),
            const SizedBox(width: 30,),
            InkWell(
              onTap: () {
                setState(() {
                  thisYearSelected = false;
                  _scrollController.jumpTo(0);
                });
              },
              child: Text((DateTime.now().year + 1).toString(), style: !thisYearSelected ? CustomTextStyles.textStyleTitle(context)!.copyWith(color: CustomColors().primaryColor) : CustomTextStyles.textStyleTitle(context)!.copyWith(color: CustomColors().descriptionTextColor),),
            )
          ],
        ),
        const SizedBox(height: 20,),
        SizedBox(
          width: double.infinity,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///HEADER (YACHTS)
              Column(
                children: [
                  Container(
                    width: tableWidth,
                    height: headerHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColors().borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Center(
                          child: Text(
                            StaticStrings.dashboardHeader,
                            style: CustomTextStyles.textStyleCalendarHeaders(context),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: tableWidth,
                    child: ListView.builder(
                        itemCount: widget.yachts.length,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: tableWidth,
                            height: rowHeight,
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors().borderColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: widget.yachts[index].name
                                          .toString()
                                          .toUpperCase(),
                                      style: CustomTextStyles.textStyleCalendarHeaders(
                                          context),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //TODO: open yacht page
                                        }),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),

              ///BOOKINGS CALENDAR
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: height,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: weeks.length,
                        itemBuilder: (BuildContext context, int index) {
                          /// Return Weeks
                          return Column(
                            children: [
                              ///HEADER -> week
                              Container(
                                width: tableWidth,
                                height: headerHeight,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: CustomColors().borderColor),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  child: Center(
                                      child: Text(weeks[index].substring(0, 6),
                                          style: CustomTextStyles
                                              .textStyleCalendarHeaders(context))),
                                ),
                              ),
                              for(Yacht y in widget.yachts) DashboardCalendarFieldWidget(yacht: y, week: index, width: tableWidth, height: rowHeight, thisYear: thisYearSelected,),
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
