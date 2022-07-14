import 'package:boatrack_management/resources/colors.dart';
import 'package:flutter/material.dart';

import '../../helpers/calendar_calculations.dart';
import '../../resources/strings.dart';
import '../../resources/text_styles.dart';

class DashboardCalendarWidget extends StatefulWidget {
  const DashboardCalendarWidget({Key? key}) : super(key: key);

  @override
  State<DashboardCalendarWidget> createState() =>
      _DashboardCalendarWidgetState();
}

class _DashboardCalendarWidgetState extends State<DashboardCalendarWidget> {
  //controllers
  final ScrollController _scrollController = ScrollController();

  //variables
  List<String> weeks = CalendarCalculations().calculateBookingWeeks();

  //measurements
  double weeksWidth = 140;
  double weeksHeight = 60;

  @override
  void initState() {
    super.initState();
    //jumpto ide za WIDTH pixela (70) je jedan

    double jumpPosition =
        (CalendarCalculations().getTodayWeekNumber() - 1) * weeksWidth;
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _scrollController.jumpTo(jumpPosition));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Row(
        children: [
          ///HEADER (YACHTS)
          Column(
            children: [
              Container(
                width: weeksWidth,
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
              )
            ],
          ),
          ///BOOKINGS CALENDAR
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 200,
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
                          Container(
                            width: weeksWidth,
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
                          )
                        ],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
