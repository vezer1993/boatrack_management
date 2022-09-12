import 'package:boatrack_management/resources/separators.dart';
import 'package:boatrack_management/resources/strings.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import '../../helpers/calendar_calculations.dart';
import '../../helpers/conversions.dart';
import '../../models/booking.dart';
import '../../models/yacht.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';

class YachtPresentationWidget extends StatefulWidget {
  final Yacht yacht;

  const YachtPresentationWidget({Key? key, required this.yacht})
      : super(key: key);

  @override
  State<YachtPresentationWidget> createState() =>
      _YachtPresentationWidgetState();
}

class _YachtPresentationWidgetState extends State<YachtPresentationWidget> {
  // Pre-defined sizes
  double containerWidth = 1480;
  double leftSideWidth = 800;
  double rightSideWidth = 600;

  double imageWidth = 300;
  double imageHeight = 250;

  double headerWidth = 100;
  double yachtValueWidth = 110;
  double checkSymbolHeight = 70;

  bool currentlyBooked = false;

  @override
  Widget build(BuildContext context) {
    ///CALCULATE THIS AND NEXT WEEK
    int thisWeek = CalendarCalculations().getWeekNumberForDate(DateTime.now());
    int nextWeek = thisWeek + 1;

    String thisWeekAvailability = widget.yacht.availabilityForWeek(thisWeek);
    String nextWeekAvailability = widget.yacht.availabilityForWeek(nextWeek);

    Text thisWeekTextWidget =
        createTextAccordingToAvailability(thisWeekAvailability);
    Text nextWeekTextWidget =
        createTextAccordingToAvailability(nextWeekAvailability);

    ///Current booking

    Booking? booking = widget.yacht.getBookingForDate();

    if (booking != null) {
      currentlyBooked = true;
    }


    Widget cleaning = CustomBoxDecorations.getTableFailSymbol(checkSymbolHeight);
    Widget checkIn = CustomBoxDecorations.getTableFailSymbol(checkSymbolHeight);
    Widget checkOut = CustomBoxDecorations.getTableFailSymbol(checkSymbolHeight);

    String dateFrom = "";
    String dateTo = "";
    if(currentlyBooked){

      if(booking!.cleaningId != null){
        cleaning = CustomBoxDecorations.getTableCheckSymbol(checkSymbolHeight);
      }

      if(booking.checkIn != null){
        checkIn = CustomBoxDecorations.getTableCheckSymbol(checkSymbolHeight);
      }

      if(booking.checkIn != null){
        checkOut = CustomBoxDecorations.getTableCheckSymbol(checkSymbolHeight);
      }

      dateFrom = Conversion.convertUtcTimeToStandardFormat(booking.datefrom.toString());
      dateTo = Conversion.convertUtcTimeToStandardFormat(booking.dateto.toString());

    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: containerWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: leftSideWidth,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageNetwork(
                        image: widget.yacht.image.toString(),
                        imageCache: CachedNetworkImageProvider(
                            widget.yacht.image.toString()),
                        width: imageWidth,
                        height: imageHeight,
                        duration: 1500,
                        curve: Curves.easeIn,
                        onPointer: false,
                        debugPrint: false,
                        fullScreen: false,
                        fitAndroidIos: BoxFit.fill,
                        fitWeb: BoxFitWeb.fill,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      Separators.dashboardHorizontalSeparator(),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getModel(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: Text(
                                              widget.yacht.model.toString(),
                                              style: CustomTextStyles
                                                  .textStyleTableColumn(
                                                      context),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getYear(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: Text(
                                              widget.yacht.year.toString(),
                                              style: CustomTextStyles
                                                  .textStyleTableColumn(
                                                      context),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getWeeksOut(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: Text(
                                              widget.yacht
                                                  .getWeeksOut()
                                                  .toString(),
                                              style: CustomTextStyles
                                                  .textStyleTableColumn(
                                                      context),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getThisWeek(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: thisWeekTextWidget,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Separators.dashboardHorizontalSeparator(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getHomeBase(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: Text(
                                              widget.yacht.homebase.toString(),
                                              style: CustomTextStyles
                                                  .textStyleTableColumn(
                                                      context),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getLength(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: Text(
                                              widget.yacht.lenght.toString(),
                                              style: CustomTextStyles
                                                  .textStyleTableColumn(
                                                      context),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getRevenue(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: Text(
                                              Conversion.priceConversion(widget
                                                      .yacht
                                                      .getTotalRevenue()) +
                                                  " €",
                                              style: CustomTextStyles
                                                  .textStyleTableColumn(
                                                      context),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: headerWidth,
                                            child: Text(
                                              StaticStrings.getNextWeek(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                      context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: yachtValueWidth,
                                            child: nextWeekTextWidget,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: currentlyBooked,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 25,),
                                    Align(alignment: Alignment.centerLeft, child: Text("CURRENT BOOKING:", style: CustomTextStyles.textStyleTableHeader(context),)),
                                    const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: headerWidth,
                                              child: Text(
                                                "Booking start:",
                                                style: CustomTextStyles
                                                    .textStyleTableHeader(
                                                    context),
                                              ),
                                            ),
                                            SizedBox(
                                              width: yachtValueWidth,
                                              child: Text(dateFrom
                                                ,
                                                style: CustomTextStyles
                                                    .textStyleTableColumn(
                                                    context),
                                              ),
                                            )
                                          ],
                                        ),
                                        Separators.dashboardHorizontalSeparator(),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: headerWidth,
                                              child: Text(
                                                "Booking end:",
                                                style: CustomTextStyles
                                                    .textStyleTableHeader(
                                                    context),
                                              ),
                                            ),
                                            SizedBox(
                                              width: yachtValueWidth,
                                              child: Text(
                                                dateTo,
                                                style: CustomTextStyles
                                                    .textStyleTableColumn(
                                                    context),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    SizedBox(
                                      width: 450,
                                      height: 100,
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("CLEANED", style: CustomTextStyles.textStyleTableHeader(context),),
                                              const SizedBox(height: 5,),
                                              cleaning
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("CHECKED IN", style: CustomTextStyles.textStyleTableHeader(context)),
                                              const SizedBox(height: 5,),
                                              checkIn
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("CHECKED OUT", style: CustomTextStyles.textStyleTableHeader(context)),
                                              const SizedBox(height: 5,),
                                              checkOut
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: rightSideWidth,
              height: imageHeight,
              color: Colors.black,
            )
          ],
        ),
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
