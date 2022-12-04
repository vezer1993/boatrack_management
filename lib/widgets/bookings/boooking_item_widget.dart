import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../models/booking_item.dart';

class BookingItemWidget extends StatefulWidget {
  final BookingItem item;
  final int row;
  const BookingItemWidget({Key? key, required this.item, required this.row,}) : super(key: key);

  @override
  State<BookingItemWidget> createState() => _BookingItemWidgetState();
}

class _BookingItemWidgetState extends State<BookingItemWidget> {
  @override
  Widget build(BuildContext context) {

    Color background = CustomColors().altBackgroundColor;

    if(widget.row % 2 != 0){
      background = Colors.transparent;
    }

    Color payableAtBaseBackground = CustomColors().successBoxBackgroundColor;
    String payableAtBaseText = "PAYABLE AT BASE";
    if(!widget.item.payableInBase!){
      payableAtBaseBackground = CustomColors().failBoxBackgroundColor;
      payableAtBaseText = "PAYED BEFORE";
    }

    return Container(
      decoration: BoxDecoration(
        color: background,
        border: Border(bottom: BorderSide(color: CustomColors().borderColor, width: 1))
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.name.toString(), style: CustomTextStyles.textStyleCalendarHeaders(context),),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Container(height: 18, width: 175, decoration: BoxDecoration(
                color: payableAtBaseBackground,
                borderRadius: BorderRadius.circular(5),
              ),
                child: Align( alignment:Alignment.center, child: Text(payableAtBaseText, style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1
                ),)),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("QT: " + widget.item.getQuantity(), style: CustomTextStyles.textStyleTableColumn(context),),
                Text("Price: " + widget.item.getPrice() + " €")
              ],
            )
          ],
        ),
      ),
    );
  }
}
