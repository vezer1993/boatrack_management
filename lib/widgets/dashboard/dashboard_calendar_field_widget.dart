import 'dart:html';

import 'package:boatrack_management/helpers/calendar_calculations.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/booking.dart';
import '../../models/yacht.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/formats.dart';

class DashboardCalendarFieldWidget extends StatefulWidget {
  ///VARIABLES
  final Yacht yacht;
  final int week;
  final double width;
  final double height;
  final bool thisYear;

  const DashboardCalendarFieldWidget(
      {Key? key,
      required this.yacht,
      required this.week,
      required this.width,
      required this.height, required this.thisYear})
      : super(key: key);

  @override
  State<DashboardCalendarFieldWidget> createState() =>
      _DashboardCalendarFieldWidgetState();
}

class _DashboardCalendarFieldWidgetState
    extends State<DashboardCalendarFieldWidget> {


  @override
  Widget build(BuildContext context) {

    String availability = widget.yacht.availability!;

    if(!widget.thisYear){
      availability = widget.yacht.availabilityNextYear!;
    }
    List<Container> days = [];
    double dayWidth = widget.width / 7;
    Color dayColor = CustomColors().calendarBookedColor;
    bool booked = false;



    ///CHECK IF WEEK IS BOOKED
    for (int i = 0; i < 7; i++) {
      if (i + (7 * widget.week) < 365) {
        if (availability[i + (7 * widget.week)] == "1") {
          days.add(
              createContainer(CustomColors().calendarBookedColor, dayWidth, i));
          booked = true;
        } else if (availability[i + (7 * widget.week)] == "0") {
          days.add(createContainer(
              CustomColors().calendarNothingColor, dayWidth, i));
        } else {
          days.add(
              createContainer(CustomColors().calendarOptionColor, dayWidth, i));
        }
      } else {
        days.add(
            createContainer(CustomColors().calendarOptionColor, dayWidth, i));
      }
    }
    ///VARIABLES FOR TOOLITP
    String dateFrom = "";
    String dateTo = "";
    String agent = "";

    ///ADD TOOLTIP
    if(booked == true){
      for(int x = 0; x < widget.yacht.bookings!.length; x++){
        DateFormat df = Formats.bookingManagerDateTimeFormat();

        DateTime dtStart = DateTime.now();
        if(widget.yacht.bookings![x].datefrom != null){
          dtStart = df.parse(widget.yacht.bookings![x].datefrom.toString());
        }else{
          print("HELLO I AM NULL");
        }

        DateTime dtFinish = DateTime.now();

        if(widget.yacht.bookings![x].dateto != null){
          dtFinish = df.parse(widget.yacht.bookings![x].dateto.toString());
        }else{
          print("HELLO I AM NULL");
        }

        int week = CalendarCalculations().getWeekNumberForDate(dtStart);
        int finishWeek = CalendarCalculations().getWeekNumberForDate(dtFinish);

        ///CHECK FOR BOOKINGS WITH MULTIPLE WEEKS
        if(finishWeek > week){
          finishWeek--;
          while(week <= finishWeek){
            if(finishWeek == widget.week){
              DateFormat donly = Formats.getDateOnlyFormat();
              dateFrom = donly.format(dtStart);
              dateTo = donly.format(dtFinish);
              if(widget.yacht.bookings![x].agent != null){
                agent = widget.yacht.bookings![x].agent.toString();
              }
            }
            finishWeek--;
          }
        }

        ///FIND BOOKING
        if(week == widget.week){
          DateFormat donly = Formats.getDateOnlyFormat();
          dateFrom = donly.format(dtStart);
          dateTo = donly.format(dtFinish);
          if(widget.yacht.bookings![x].agent != null){
            agent = widget.yacht.bookings![x].agent.toString();
          }
        }
      }
    }

    MouseCursor cursor = SystemMouseCursors.basic;

    String tooltipMessage = "";
    if(booked == true){
      tooltipMessage = dateFrom + " - " + dateTo + "\n" + agent;
      cursor = SystemMouseCursors.click;
    }

    return MouseRegion(
      cursor: cursor,
      child: Tooltip(
        message: tooltipMessage,
        textStyle: CustomTextStyles.tooltipTextStyle(context),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: dayColor,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            CustomBoxDecorations.containerBoxShadow()
          ]
        ),
        child: GestureDetector(
          onTap: (){
            ///TODO: OPEN BOOKING ON CLICK
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: CustomBoxDecorations.topAndBottomBorder(),
            child: Row(
              children: [
                for (Container c in days) c,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container createContainer(Color color, double width, int i) {
    Container c;
    i++;
    if (i % 7 == 0) {
      c = Container(
        width: width,
        height: widget.height,
        decoration: BoxDecoration(
            color: color,
            border: Border(
              right: BorderSide(width: 0.5, color: CustomColors().borderColor),
            )),
      );
    } else {
      c = Container(
        width: width,
        height: widget.height,
        color: color,
      );
    }

    return c;
  }
}
