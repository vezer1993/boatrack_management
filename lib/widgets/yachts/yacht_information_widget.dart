import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/resources/values.dart';
import 'package:boatrack_management/widgets/yachts/yacht_booking_list_widget.dart';
import 'package:flutter/material.dart';

import '../../models/yacht.dart';

class YachtInformationWidget extends StatefulWidget {
  final Yacht yacht;
  final double containerHeight;
  const YachtInformationWidget({Key? key, required this.yacht, required this.containerHeight}) : super(key: key);

  @override
  State<YachtInformationWidget> createState() => _YachtInformationWidgetState();
}

class _YachtInformationWidgetState extends State<YachtInformationWidget> {

  double headerWidth = 80;
  double headerHeight = StaticValues.halfContainerTableHeaderHeight;

  int selectedTabIndex = 0;
  List<bool> selectedTab = [true, false, false];


  @override
  Widget build(BuildContext context) {

    double containerHeight = widget.containerHeight - (2 * StaticValues.standardContainerPadding) - StaticValues.halfContainerTableHeaderHeight - StaticValues.itemVerticalSeparator;

    List<Widget> selectedWidget = [YachtBookingListWidget(bookings: widget.yacht.getBookingList(), containerHeight: containerHeight,), Text("hello 2"), Text("hello 3")];

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
                    "ROUTES", style: CustomTextStyles.textStyleTableHeader(context),
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
                    "CLEANING", style: CustomTextStyles.textStyleTableHeader(context),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: StaticValues.itemVerticalSeparator,),
        selectedWidget[selectedTabIndex]
      ],
    );
  }
}
