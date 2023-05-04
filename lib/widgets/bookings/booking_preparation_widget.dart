import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/models/booking_preparation.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/booking_api.dart';
import 'package:boatrack_management/widgets/dialogs/dialog_yacht_explorer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../dialogs/dialog_prep_showcase.dart';

class BookingPreparationWidget extends StatefulWidget {
  final String bookingID;
  final double widgetWidth;
  final Yacht yacht;
  const BookingPreparationWidget({Key? key, required this.bookingID, required this.widgetWidth, required this.yacht}) : super(key: key);

  @override
  State<BookingPreparationWidget> createState() => _BookingPreparationWidgetState();
}

class _BookingPreparationWidgetState extends State<BookingPreparationWidget> {

  late BookingPreparation futureData;
  bool dataLoaded = false;

  Future getBookingPrep() async {
    if (!dataLoaded) {
      futureData = await getBookingPreparationStatus(widget.bookingID.toString());
    }
    return futureData;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBookingPrep(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {

            Widget checkIn = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget checkOut = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget cleaning = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget guestsArrived = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget prepPreCheckout = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );
            Widget prepPostCheckout = FaIcon(
              FontAwesomeIcons.x,
              size: 15,
              color: CustomColors().failBoxCheckMarkColor,
            );

            if(futureData.checkIn != null){
              checkIn = InkWell(onTap: (){},child: Text(Conversion.convertISOTimeToStandardFormat(futureData.checkIn!.timestamp.toString()), style: CustomTextStyles
                  .textStyleTableColumn(
                  context)?.copyWith(decoration: TextDecoration.underline, color: CustomColors().primaryColor),));
            }

            if(futureData.checkOut != null){
              checkOut = InkWell(onTap: (){},child: Text(Conversion.convertISOTimeToStandardFormat(futureData.checkOut!.timestamp.toString()), style: CustomTextStyles
                  .textStyleTableColumn(
                  context)?.copyWith(decoration: TextDecoration.underline, color: CustomColors().primaryColor),));
            }

            if(futureData.cleaning != null){
              cleaning = InkWell(onTap: (){
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogYachtExplorer(yacht: widget.yacht, checkInOut: null, cleaning: futureData.cleaning,);
                  },
                );
              },child: Text(Conversion.convertISOTimeToStandardFormat(futureData.cleaning!.timeFinished.toString()), style: CustomTextStyles
                  .textStyleTableColumn(
                  context)?.copyWith(decoration: TextDecoration.underline, color: CustomColors().primaryColor),));
            }

            if(futureData.preCheckinPrep != null){
              prepPreCheckout = InkWell(onTap: (){
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return(DialogPrepShowcase(prep: futureData.preCheckinPrep!, yacht: widget.yacht,));
                  },
                );
              },child: Text(Conversion.convertISOTimeToStandardFormat(futureData.preCheckinPrep!.timestampData.toString()), style: CustomTextStyles
                  .textStyleTableColumn(
                  context)?.copyWith(decoration: TextDecoration.underline, color: CustomColors().primaryColor),));
            }

            if(futureData.postCheckoutPrep != null){
              prepPostCheckout = InkWell(onTap: (){
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return(DialogPrepShowcase(prep: futureData.postCheckoutPrep!, yacht: widget.yacht,));
                  },
                );
              },child: Text(Conversion.convertISOTimeToStandardFormat(futureData.postCheckoutPrep!.timestampData.toString()), style: CustomTextStyles
                  .textStyleTableColumn(
                  context)?.copyWith(decoration: TextDecoration.underline, color: CustomColors().primaryColor),));
            }

            if(futureData.guestsArrived != null){
              if(futureData.guestsArrived!){
                guestsArrived = FaIcon(
                  FontAwesomeIcons.check,
                  size: 15,
                  color: CustomColors().successBoxCheckMarkColor,
                );
              }
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CHECK OUT:     ", style: CustomTextStyles.textStyleTableColumn(context),), checkOut],)),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CHECK-OUT PREP:     ", style: CustomTextStyles.textStyleTableColumn(context),), prepPostCheckout],)),),
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CLEANING:     ", style: CustomTextStyles.textStyleTableColumn(context),), cleaning],)),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("GUESTS ARRIVED:     ", style: CustomTextStyles.textStyleTableColumn(context),), guestsArrived],)),),
                    ],
                  ),
                  const SizedBox(height: 7,),
                  Container(width: double.infinity, height: 1, color: CustomColors().borderColor,),
                  const SizedBox(height: 7,),
                  Row(
                    children: [
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CHECK-IN PREP:     ", style: CustomTextStyles.textStyleTableColumn(context),), prepPreCheckout],)),),
                      Expanded(flex: 1,child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text("CHECK IN:     ", style: CustomTextStyles.textStyleTableColumn(context),), checkIn],)),),
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}