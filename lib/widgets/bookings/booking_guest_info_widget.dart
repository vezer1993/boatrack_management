import 'package:boatrack_management/models/guest.dart';
import 'package:boatrack_management/services/booking_api.dart';
import 'package:flutter/material.dart';

import '../../models/booking.dart';
import '../../resources/colors.dart';
import '../../resources/styles/text_styles.dart';

class BookingGuestInfoWidget extends StatefulWidget {
  final Booking booking;
  const BookingGuestInfoWidget({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingGuestInfoWidget> createState() => _BookingGuestInfoWidgetState();
}

class _BookingGuestInfoWidgetState extends State<BookingGuestInfoWidget> {
  late Guest futureData;
  bool dataLoaded = false;

  Future getGuestInfo() async {
    if (!dataLoaded) {
      if(widget.booking.guestId != null){
        print(widget.booking.guestId);
        futureData = await getGuest(widget.booking.guestId.toString());
      }
    }
    return futureData;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGuestInfo(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {

            String gName = "-";
            String gContact = "-";
            String crewCount = "-";
            String note = "-";

            if(futureData != null){
              if(futureData.name != null){
                gName = futureData.name.toString();
              }
              if(futureData.email != null){
                gContact = futureData.email.toString();
              }
            }

            if(widget.booking.crewcount != null){
              if(widget.booking.crewcount! > 0){
                crewCount = widget.booking.crewcount.toString();
              }

            }

            if(widget.booking.note != null){
              note = widget.booking.note.toString();
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("GUEST:     ", style: CustomTextStyles.textStyleTableColumn(context),), Text(gName, style: CustomTextStyles.textStyleTableColumn(context),)],)),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CONTACT:     ", style: CustomTextStyles.textStyleTableColumn(context),), Text(gContact, style: CustomTextStyles.textStyleTableColumn(context),)],)),),
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CREW COUNT:     ", style: CustomTextStyles.textStyleTableColumn(context),), Text(crewCount, style: CustomTextStyles.textStyleTableColumn(context),)],),
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("NOTE:     ", style: CustomTextStyles.textStyleTableColumn(context),), Text(note, style: CustomTextStyles.textStyleTableColumn(context),)],),
                  )
                ],
              ),
            );
          }
        });
  }
}
