import 'package:boatrack_management/helpers/calendar_calculations.dart';
import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/models/booking.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/widgets/bookings/booking_presentation_widget.dart';
import 'package:flutter/material.dart';

import '../resources/separators.dart';
import '../resources/styles/text_styles.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/user_interface/header.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  DateTime dtNow = DateTime.now();


  @override
  Widget build(BuildContext context) {

    String nextSaturday = CalendarCalculations().getNextSaturdayForDate(dtNow).toString().substring(0,10);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeaderWidget(previousPage: '',),
            Separators.dashboardVerticalSeparator(),
            FullWidthContainer(
              title: "",
              childWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("BOOKING       ", style: CustomTextStyles.textStyleTitle(context),),
                    ),
                    IconButton(onPressed: () {
                      setState(() {
                        dtNow = DateTime(dtNow.year, dtNow.month, dtNow.day - 7);
                      });
                    }, icon: Icon(Icons.arrow_back, color: CustomColors().primaryColor,)),
                    const SizedBox(width: 3,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(getPresentationTitle(dtNow), style: CustomTextStyles.textStyleTitle(context),),
                    ),
                    const SizedBox(width: 3,),
                    IconButton(onPressed: () {
                      setState(() {
                        dtNow = DateTime(dtNow.year, dtNow.month, dtNow.day + 7);
                      });
                    }, icon: Icon(Icons.arrow_forward, color: CustomColors().primaryColor,))
                  ],
                ),
                BookingPresentationWidget(bookingStartDate: nextSaturday,)
              ],),
            ),
            Separators.dashboardVerticalSeparator(),
          ],
        ),
      ),
    );
  }

  String getPresentationTitle(DateTime dtSelected){
    DateTime nextSaturday = CalendarCalculations().getNextSaturdayForDate(dtSelected);
    DateTime nextNextSaturday = DateTime(nextSaturday.year, nextSaturday.month, nextSaturday.day + 7);
    return Conversion.convertISOTimeToStandardFormat(nextSaturday.toIso8601String()) + " - " + Conversion.convertISOTimeToStandardFormat(nextNextSaturday.toIso8601String());
  }
}
