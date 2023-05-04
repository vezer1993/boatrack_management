import 'package:boatrack_management/models/prep_object.dart';
import 'package:boatrack_management/models/prep_segment.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../helpers/conversions.dart';
import '../../models/account.dart';
import '../../models/yacht.dart';
import '../../services/accounts_api.dart';

class DialogPrepShowcase extends StatefulWidget {
  final PrepObject prep;
  final Yacht yacht;

  const DialogPrepShowcase({Key? key, required this.prep, required this.yacht})
      : super(key: key);

  @override
  State<DialogPrepShowcase> createState() => _DialogPrepShowcaseState();
}

class _DialogPrepShowcaseState extends State<DialogPrepShowcase> {
  Accounts? employee;
  bool dataLoaded = false;

  Future getIssueData() async {
    if (!dataLoaded) {
      employee = await getSelectedUser(widget.prep!.accountId!);
      dataLoaded = true;
    }
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double containerWidth = 700;
    double containerHeight = 900;

    if (width < 800) {
      containerWidth = width * 0.7;
      height = height * 0.8;
    }

    List<PrePostSegment> segments = widget.prep.getSegments();

    for (PrePostSegment seg in segments) {
      print(seg.rating);
    }

    return Dialog(
        child: FutureBuilder(
            future: getIssueData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text("NO CONNECTION");
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {

                int listviewHeight = 60 * segments.length;
                double listviewWidth = containerWidth - 40;

                return Container(
                  height: containerHeight,
                  width: containerWidth,
                  color: CustomColors().websiteBackgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.directions_boat,
                              color: CustomColors().navigationTextColor,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.yacht.name.toString(),
                              style: CustomTextStyles.textStyleTitle(context),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "-",
                              style: CustomTextStyles.textStyleTitle(context),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              Conversion.convertISOTimeToStandardFormatWithTime(
                                  widget.prep.timestampData.toString()),
                              style: CustomTextStyles.textStyleTitle(context),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: listviewWidth,
                            height: listviewHeight.toDouble(),
                            child: ListView.builder(
                                itemCount: segments.length,
                                itemBuilder: (BuildContext context, int index) {

                                  String description = "";
                                  if(segments[index].description != null){
                                    description = segments[index].description.toString();
                                  }

                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: listviewWidth / 4, child: Text(segments[index].name.toString(), style: CustomTextStyles.textStyleTableColumn(context),)),
                                          const SizedBox(width: 20,),
                                          SizedBox(width: listviewWidth / 6, child: Text(segments[index].rating.toString(), style: CustomTextStyles.textStyleTableColumn(context),)),
                                          const SizedBox(width: 20,),
                                          SizedBox(width: (listviewWidth / 5) * 2, height: 48, child: Center(child: Text(description, style: CustomTextStyles.textStyleTableColumn(context),))),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Container(height: 2, width: listviewWidth, color: CustomColors().unSelectedItemColor,)
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: CustomColors().navigationTextColor,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              employee!.name.toString(),
                              style: CustomTextStyles.textStyleTitle(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
