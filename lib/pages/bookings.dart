import 'package:boatrack_management/helpers/calendar_calculations.dart';
import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/models/booking.dart';
import 'package:boatrack_management/widgets/bookings/booking_presentation_widget.dart';
import 'package:flutter/material.dart';

import '../resources/separators.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/user_interface/header.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {


  @override
  Widget build(BuildContext context) {

    String nextSaturday = CalendarCalculations().getNextSaturdayForDate(DateTime.now()).toString().substring(0,10);

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
              title: "UPCOMING BOOKINGS",
              childWidget: BookingPresentationWidget(bookingStartDate: nextSaturday,),
            ),
            Separators.dashboardVerticalSeparator(),
          ],
        ),
      ),
    );
  }
}
