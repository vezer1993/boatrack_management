import 'package:boatrack_management/models/booking.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../helpers/conversions.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/values.dart';

class YachtBookingListWidget extends StatefulWidget {
  final List<Booking>? bookings;
  final double containerHeight;

  const YachtBookingListWidget(
      {Key? key, required this.bookings, required this.containerHeight})
      : super(key: key);

  @override
  State<YachtBookingListWidget> createState() => _YachtBookingListWidgetState();
}

class _YachtBookingListWidgetState extends State<YachtBookingListWidget> {
  double pageSelectionHeight = 50;
  double columnWidth = 130;
  double columnHeight = 37;

  int itemsPerPage = 4;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.bookings == null || widget.bookings!.isEmpty) {
      return SizedBox(
        height: widget.containerHeight,
        child: Center(
          child: Text(
            "Currently no bookings!",
            style: CustomTextStyles.textStyleTitle(context),
          ),
        ),
      );
    }

    int pageCount = (widget.bookings!.length / 4).ceil();

    return SizedBox(
        height: widget.containerHeight,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: columnWidth * 6,
                height: widget.containerHeight - pageSelectionHeight,
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemsPerPage+1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        // return the header
                        return Container(
                          height: columnHeight,
                          width: columnWidth * 6,
                          decoration:
                              CustomBoxDecorations.tableHeaderContainer(),
                          child: Row(
                            children: [
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text("FROM",
                                          style: CustomTextStyles
                                              .textStyleTableHeader(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text("TO",
                                          style: CustomTextStyles
                                              .textStyleTableHeader(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(
                                    "AGENT",
                                    style:
                                        CustomTextStyles.textStyleTableHeader(
                                            context),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text("GUEST",
                                          style: CustomTextStyles
                                              .textStyleTableHeader(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text("CREW",
                                          style: CustomTextStyles
                                              .textStyleTableHeader(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text("PRICE",
                                          style: CustomTextStyles
                                              .textStyleTableHeader(context))),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      index -= 1;

                      if ((index + ((page - 1) * itemsPerPage)) < widget.bookings!.length) {
                        int i = index + ((page - 1) * itemsPerPage);

                        Booking b = widget.bookings![i];
                        String bFrom =
                            Conversion.convertUtcTimeToStandardFormat(
                                b.datefrom.toString());
                        String bTo = Conversion.convertUtcTimeToStandardFormat(
                            b.dateto.toString());

                        String agent = "-";
                        String guest = "-";
                        String crewCount = "-";
                        String price = Conversion.priceConversion(
                                double.parse(b.priceFinal.toString())) +
                            " €";

                        if (b.agent != null) {
                          agent = b.agent.toString();
                        }

                        if (b.guestId != null) {
                          //connect to guest
                        }

                        if (b.crewcount != null) {
                          crewCount = b.crewcount.toString();
                        }

                        return Container(
                          width: columnWidth * 6,
                          height: (widget.containerHeight -
                                  columnHeight -
                                  pageSelectionHeight) /
                              itemsPerPage,
                          decoration: CustomBoxDecorations.topAndBottomBorder(),
                          child: Row(
                            children: [
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(bFrom,
                                          style: CustomTextStyles
                                              .textStyleTableColumn(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(bTo,
                                          style: CustomTextStyles
                                              .textStyleTableColumn(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(
                                    agent,
                                    style:
                                        CustomTextStyles.textStyleTableColumn(
                                            context),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(guest,
                                          style: CustomTextStyles
                                              .textStyleTableColumn(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(crewCount,
                                          style: CustomTextStyles
                                              .textStyleTableColumn(context))),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Padding(
                                  padding:
                                      StaticValues.standardTableItemPadding(),
                                  child: Center(
                                      child: Text(price,
                                          style: CustomTextStyles
                                              .textStyleTableColumn(context))),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
            SizedBox(
                height: pageSelectionHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (page != 1) {
                            setState(() {
                              page--;
                            });
                          }
                        },
                        icon: const Icon(Icons.chevron_left), color: CustomColors().navigationIconColor),
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pageCount,
                        itemBuilder: (BuildContext context, int index) {

                          int number = index + 1;

                          Color textColor = CustomColors().unSelectedItemColor;

                          if(page == number){
                            textColor = CustomColors().navigationTitleColor;
                          }

                          return InkWell(
                            onTap: (){
                              setState(() {
                                page = number;
                              });
                            },
                            child: Container(
                              height: pageSelectionHeight,
                              width: pageSelectionHeight,
                              child: Center(child:Text(number.toString(), style: CustomTextStyles.textStyleTableColumn(context)?.copyWith(color: textColor),)),
                            ),
                          );
                        }),
                    IconButton(
                        onPressed: () {
                          if (page != pageCount) {
                            setState(() {
                              page++;
                            });
                          }
                        },
                        icon: Icon(Icons.chevron_right, color: CustomColors().navigationIconColor,))
                  ],
                ))
          ],
        ));
  }
}
