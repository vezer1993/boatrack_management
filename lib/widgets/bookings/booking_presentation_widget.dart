import 'package:boatrack_management/models/booking.dart';
import 'package:boatrack_management/models/booking_item.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:boatrack_management/widgets/bookings/booking_preparation_widget.dart';
import 'package:boatrack_management/widgets/bookings/boooking_item_widget.dart';
import 'package:boatrack_management/widgets/dialogs/dialog_edit_guest_info.dart';
import 'package:flutter/material.dart';

import '../../helpers/conversions.dart';
import '../../models/yacht.dart';
import '../../services/booking_api.dart';
import 'booking_guest_info_widget.dart';

class BookingPresentationWidget extends StatefulWidget {
  final String bookingStartDate;

  const BookingPresentationWidget({Key? key, required this.bookingStartDate})
      : super(key: key);

  @override
  State<BookingPresentationWidget> createState() =>
      _BookingPresentationWidgetState();
}

class _BookingPresentationWidgetState extends State<BookingPresentationWidget> {
  late List<Yacht> futureData;
  bool dataLoaded = false;

  Future getFutureData() async {
    if (!dataLoaded) {
      futureData = await getYachtList(false);
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getFutureData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            /// GET ITEMS BOOKINGS
            List<Booking> bookings = [];
            for (Yacht y in futureData) {
              Booking? temp = y.getBookingForGivenDate(widget.bookingStartDate);
              if (temp != null) {
                bookings.add(temp);
              }
            }

            ///CALCULATIONS
            double containerHeight = 300;
            if(bookings.length > 0){
              containerHeight = (290 * (bookings.length.toDouble())) + (20 * (bookings.length - 1));
            }
            double containerWidth = 1400;

            double titleRowHeight = 40;
            double dateRowHeight = 40;
            double rowPadding = 10;
            double columnHeight = 200;
            double columnWidth = containerWidth - 4;

            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: containerHeight,
                  width: containerWidth,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20,);
                      },
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bookings.length,
                      itemBuilder: (BuildContext context, int index) {
                        ///CALCULATE THIS BOOKING AND WIDGETS
                        Booking? b = bookings[index];

                        String bFrom = "";
                        String bTo = "";

                        if (b != null) {
                          bFrom = Conversion.convertUtcTimeToStandardFormat(
                              b.datefrom.toString());
                          bTo = Conversion.convertUtcTimeToStandardFormat(
                              b.dateto.toString());
                        }

                        List<BookingItem> items = b.getPayableAtBaseBookingItems();
                        final _scrollController = ScrollController();
                        if (b != null) {}

                        return Container(
                          decoration: BoxDecoration(
                            color: CustomColors().tableHeaderColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              CustomBoxDecorations.containerBoxShadow(),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: containerWidth,
                                  height: titleRowHeight,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              bookings[index].yacht!.name.toString(),
                                              style: CustomTextStyles.textStyleTitle(
                                                  context),
                                            )),
                                      ),
                                      PopupMenuButton(
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: 'guest_info',
                                              child: Text('GUEST INFO', style: CustomTextStyles.textStyleTableColumn(context),),
                                            ),
                                            PopupMenuItem(
                                              value: 'arrive',
                                              child: Text('GUESTS ARRIVED', style: CustomTextStyles.textStyleTableColumn(context),),
                                            ),
                                          ];
                                        },
                                        onSelected: (String value) async{
                                          if(value == "arrive"){
                                            bool success = await setGuestsArrived(this.context, b.id.toString());
                                            if(success){
                                              setState(() {
                                                rebuildAllChildren(context);
                                              });
                                            }
                                          }else if (value == "guest_info"){
                                            bool? success = await showDialog<bool>(context: context, builder: (context) => DialogEditGuestInfo(booking: b));
                                            dataLoaded = false;
                                            setState(() {
                                              rebuildAllChildren(context);
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(
                                width: containerWidth,
                                height: dateRowHeight,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        bFrom + "  --->  " + bTo,
                                        style: CustomTextStyles.textStyleTitle(
                                            context),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: rowPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// SECTION 1 (INFORMATION)
                                  Container(
                                    height: columnHeight,
                                    width: columnWidth / 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: 15,
                                            child: Text(
                                              "INFORMATION",
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(context),
                                            )),
                                        SizedBox(
                                            width: columnWidth / 3,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: (columnWidth / 3) - 300,
                                                  height: 2,
                                                  color:
                                                  CustomColors().primaryColor,
                                                ))),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          width: columnWidth / 3,
                                          height: 173,
                                          child: Scrollbar(
                                            isAlwaysShown: true,
                                            controller: _scrollController,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              controller: _scrollController,
                                              child: Column(
                                                children: [
                                                  for(int i = 0; i < items.length; i++)
                                                    BookingItemWidget(item: items[i], row: i)
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  ///DIVIDER
                                  SizedBox(
                                    height: columnHeight,
                                    width: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: columnHeight - 40,
                                        width: 2,
                                        color: CustomColors().primaryColor,
                                      ),
                                    ),
                                  ),

                                  ///SECTION 2 (ITEMS)
                                  Container(
                                    height: columnHeight,
                                    width: columnWidth / 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: 15,
                                            child: Text(
                                              "PREPARATION",
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(context),
                                            )),
                                        SizedBox(
                                            width: columnWidth / 3,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: (columnWidth / 3) - 300,
                                                  height: 2,
                                                  color:
                                                  CustomColors().primaryColor,
                                                ))),
                                        const SizedBox(height: 10,),
                                        BookingPreparationWidget(bookingID: b.id.toString(), widgetWidth: columnWidth / 3, yacht: b.yacht!,)
                                      ],
                                    ),
                                  ),

                                  ///DIVIDER
                                  SizedBox(
                                    height: columnHeight,
                                    width: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: columnHeight - 40,
                                        width: 2,
                                        color: CustomColors().primaryColor,
                                      ),
                                    ),
                                  ),

                                  ///SECTION 3 (GUEST INFO)
                                  Container(
                                    height: columnHeight,
                                    width: columnWidth / 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: 15,
                                            child: Text(
                                              "GUEST INFO",
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(context),
                                            )),
                                        SizedBox(
                                            width: columnWidth / 3,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: (columnWidth / 3) - 300,
                                                  height: 2,
                                                  color:
                                                  CustomColors().primaryColor,
                                                ))),
                                        const SizedBox(height: 10,),
                                        BookingGuestInfoWidget(booking: b,)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            );
          }
        });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }
}
