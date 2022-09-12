import 'package:flutter/material.dart';
import '../../helpers/conversions.dart';
import '../../models/booking.dart';
import '../../models/yacht.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class DashboardCurrentBookingWidget extends StatefulWidget {
  final List<Yacht> yachts;

  const DashboardCurrentBookingWidget({Key? key, required this.yachts}) : super(key: key);

  @override
  State<DashboardCurrentBookingWidget> createState() => _DashboardCurrentBookingWidgetState();
}

class _DashboardCurrentBookingWidgetState extends State<DashboardCurrentBookingWidget> {
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
                                  child: Text("FROM - TO",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("CLEANING",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("CHECK IN",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context))),
                            )),
                        SizedBox(
                            width: columnWidth,
                            child: Padding(
                              padding: StaticValues.standardTableItemPadding(),
                              child: Center(
                                  child: Text("CHECK OUT",
                                      style:
                                      CustomTextStyles.textStyleTableHeader(
                                          context))),
                            )),
                      ],
                    ));
              }
              index -= 1;
              ///CALCULATE THIS BOOKING AND WIDGETS
              Booking? b = widget.yachts[index].getBookingForDate();

              String bFrom = "";
              String bTo = "";

              if(b != null){
                bFrom = Conversion.convertUtcTimeToStandardFormat(b.datefrom.toString());
                bTo = Conversion.convertUtcTimeToStandardFormat(b.dateto.toString());
              }

              Widget cleaning = CustomBoxDecorations.getTableFailSymbol(columnHeight);
              Widget checkIn = CustomBoxDecorations.getTableFailSymbol(columnHeight);
              Widget checkOut = CustomBoxDecorations.getTableFailSymbol(columnHeight);


              if(b != null){

              }


              return Container(
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
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(bFrom,
                              style:
                              CustomTextStyles.textStyleTableColumn(
                                  context)),
                          Text("-", style:
                          CustomTextStyles.textStyleTableColumn(
                              context)),
                          Text(bTo,
                              style:
                              CustomTextStyles.textStyleTableColumn(
                                  context)),
                        ],
                      ),
                      ),
                    ),
                    SizedBox(
                      width: columnWidth,
                      child: Center(
                        child: cleaning
                      ),
                    ),
                    SizedBox(
                      width: columnWidth,
                      child: Center(
                        child: checkIn
                      ),
                    ),
                    SizedBox(
                      width: columnWidth,
                      child: Center(
                        child: checkOut
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Text createTextAccordingToAvailability(String availability){
    if(availability == "1"){
      return Text(
        StaticStrings.getTableYachtOut(), style: CustomTextStyles.textStyleTableYachtStatusColumn(context, CustomColors().calendarBookedColor),
      );
    }else if(availability == "0"){
      return Text(
        StaticStrings.getTableYachtHome(), style: CustomTextStyles.textStyleTableYachtStatusColumn(context, CustomColors().calendarHomeColor),
      );
    }else{
      return Text(
        StaticStrings.getTableYachtOption(), style: CustomTextStyles.textStyleTableYachtStatusColumn(context, CustomColors().calendarOptionColor),
      );
    }
  }
}
