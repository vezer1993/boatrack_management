import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/resources/values.dart';
import 'package:boatrack_management/widgets/yachts/yacht_booking_list_widget.dart';
import 'package:boatrack_management/widgets/yachts/yacht_check_in_out_list_widget.dart';
import 'package:boatrack_management/widgets/yachts/yacht_cleaning_list_widget.dart';
import 'package:boatrack_management/widgets/yachts/yacht_issues_list_widget.dart';
import 'package:flutter/material.dart';

import '../../models/cleaning.dart';
import '../../models/yacht.dart';

class YachtInformationWidget extends StatefulWidget {
  final Yacht yacht;
  final double containerHeight;
  final Function? callback;
  const YachtInformationWidget({Key? key, required this.yacht, required this.containerHeight, this.callback}) : super(key: key);

  @override
  State<YachtInformationWidget> createState() => _YachtInformationWidgetState();
}

class _YachtInformationWidgetState extends State<YachtInformationWidget> {

  double headerWidth = 80;
  double headerHeight = StaticValues.halfContainerTableHeaderHeight;

  int selectedTabIndex = 0;
  List<bool> selectedTab = [true, false, false, false, false, false];


  @override
  Widget build(BuildContext context) {

    double containerHeight = widget.containerHeight - (2 * StaticValues.standardContainerPadding) - StaticValues.halfContainerTableHeaderHeight - StaticValues.itemVerticalSeparator;

    List<Widget> selectedWidget = [YachtBookingListWidget(bookings: widget.yacht.getBookingList(), containerHeight: containerHeight,), YachtCheckInOutListWidget(yacht: widget.yacht, containerHeight: containerHeight, checkIn: true), YachtCheckInOutListWidget(yacht: widget.yacht, containerHeight: containerHeight, checkIn: false), YachtCleaningListWidget(yacht: widget.yacht, containerHeight: containerHeight, callback: callback,), YachtIssueListWidget(yacht: widget.yacht, containerHeight: containerHeight), Text("HELLO 6")];

    return Column(
      children: [
        /// SELECTION TAB
        Row(
          children: [
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () {
                setState(() {
                  selectedTab[selectedTabIndex] = false;
                  selectedTabIndex = 0;
                  selectedTab[selectedTabIndex] = true;
                });
              },
              child: Container(
                height: headerHeight,
                width: headerWidth,
                color: selectedTab[0] == true ? CustomColors().selectedItemColor  : CustomColors().unSelectedItemColor,
                child: Center(
                  child: Text(
                    "BOOKINGS", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2,),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: (){
                setState(() {
                  selectedTab[selectedTabIndex] = false;
                  selectedTabIndex = 1;
                  selectedTab[selectedTabIndex] = true;
                });
              },
              child: Container(
                height: headerHeight,
                width: headerWidth,
                color: selectedTab[1] == true ? CustomColors().selectedItemColor  : CustomColors().unSelectedItemColor,
                child: Center(
                  child: Text(
                    "CHECK IN", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2,),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: (){
                setState(() {
                  selectedTab[selectedTabIndex] = false;
                  selectedTabIndex = 2;
                  selectedTab[selectedTabIndex] = true;
                });
              },
              child: Container(
                height: headerHeight,
                width: headerWidth,
                color: selectedTab[2] == true ? CustomColors().selectedItemColor  : CustomColors().unSelectedItemColor,
                child: Center(
                  child: Text(
                    "CHECK OUT", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2,),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: (){
                setState(() {
                  selectedTab[selectedTabIndex] = false;
                  selectedTabIndex = 3;
                  selectedTab[selectedTabIndex] = true;
                });
              },
              child: Container(
                height: headerHeight,
                width: headerWidth,
                color: selectedTab[3] == true ? CustomColors().selectedItemColor  : CustomColors().unSelectedItemColor,
                child: Center(
                  child: Text(
                    "CLEANING", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2,),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: (){
                setState(() {
                  selectedTab[selectedTabIndex] = false;
                  selectedTabIndex = 4;
                  selectedTab[selectedTabIndex] = true;
                });
              },
              child: Container(
                height: headerHeight,
                width: headerWidth,
                color: selectedTab[4] == true ? CustomColors().selectedItemColor  : CustomColors().unSelectedItemColor,
                child: Center(
                  child: Text(
                    "ISSUES", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2,),
            InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: (){
                setState(() {
                  selectedTab[selectedTabIndex] = false;
                  selectedTabIndex = 5;
                  selectedTab[selectedTabIndex] = true;
                });
              },
              child: Container(
                height: headerHeight,
                width: headerWidth,
                color: selectedTab[5] == true ? CustomColors().selectedItemColor  : CustomColors().unSelectedItemColor,
                child: Center(
                  child: Text(
                    "ROUTES", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: StaticValues.itemVerticalSeparator,),
        selectedWidget[selectedTabIndex]
      ],
    );
  }

  void callback(Cleaning c){
    widget.callback!(c);
  }
}
