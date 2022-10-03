import 'package:boatrack_management/models/check_in_out.dart';
import 'package:boatrack_management/models/check_model.dart';
import 'package:boatrack_management/models/cleaning.dart';
import 'package:boatrack_management/models/issues.dart';
import 'package:flutter/material.dart';
import '../../helpers/conversions.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';
import '../../services/yachts_api.dart';
import 'dart:html' as html;

class YachtCleaningListWidget extends StatefulWidget {
  final Yacht yacht;
  final double containerHeight;

  const YachtCleaningListWidget(
      {Key? key, required this.yacht, required this.containerHeight})
      : super(key: key);

  @override
  State<YachtCleaningListWidget> createState() =>
      _YachtCleaningListWidgetState();
}

class _YachtCleaningListWidgetState extends State<YachtCleaningListWidget> {
  @override
  double pageSelectionHeight = 50;
  double columnWidth = 130;
  double columnHeight = 37;

  int itemsPerPage = 4;
  int page = 1;

  bool dataLoaded = false;
  List<Cleaning> data = [];

  Future getIssuesForYacht() async {
    if (!dataLoaded) {
      data = await getCleanings(widget.yacht.id!);
      dataLoaded = true;
    }
    return data;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIssuesForYacht(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (data.isEmpty) {
              return SizedBox(
                height: widget.containerHeight,
                child: Center(
                  child: Text(
                    "Currently no data",
                    style: CustomTextStyles.textStyleTitle(context),
                  ),
                ),
              );
            }

            int pageCount = (data.length / 4).ceil();

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
                            itemCount: itemsPerPage + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                // return the header
                                return Container(
                                  height: columnHeight,
                                  width: columnWidth * 5,
                                  decoration: CustomBoxDecorations
                                      .tableHeaderContainer(),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("STARTED",
                                                  style: CustomTextStyles
                                                      .textStyleTableHeader(
                                                      context))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("FINISHED",
                                                  style: CustomTextStyles
                                                      .textStyleTableHeader(
                                                      context))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 2,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text(
                                                "EMPLOYEE",
                                                style: CustomTextStyles
                                                    .textStyleTableHeader(context),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("ISSUES",
                                                  style: CustomTextStyles
                                                      .textStyleTableHeader(
                                                      context))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              index -= 1;

                              if ((index + ((page - 1) * itemsPerPage)) <
                                  data.length) {
                                int i = index + ((page - 1) * itemsPerPage);

                                Cleaning b = data[i];

                                String dateStarted = Conversion.convertISOTimeToStandardFormatWithTime(
                                    b.timeStarted.toString());
                                String dateFinished = Conversion.convertISOTimeToStandardFormatWithTime(
                                    b.timeFinished.toString());

                                return Container(
                                  width: columnWidth * 5,
                                  height: (widget.containerHeight -
                                      columnHeight -
                                      pageSelectionHeight) /
                                      itemsPerPage,
                                  decoration:
                                  CustomBoxDecorations.topAndBottomBorder(),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text(dateStarted,
                                                  style: CustomTextStyles
                                                      .textStyleTableColumn(
                                                      context))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                            child: Text(dateFinished,
                                                style: CustomTextStyles
                                                    .textStyleTableColumn(
                                                    context)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 2,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text(
                                                b.employee.toString(),
                                                style: CustomTextStyles
                                                    .textStyleTableColumn(context),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text(b.hasIssues.toString(),
                                                  style: CustomTextStyles
                                                      .textStyleTableColumn(
                                                      context))),
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
                                icon: const Icon(Icons.chevron_left),
                                color: CustomColors().navigationIconColor),
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: pageCount,
                                itemBuilder: (BuildContext context, int index) {
                                  int number = index + 1;

                                  Color textColor =
                                      CustomColors().unSelectedItemColor;

                                  if (page == number) {
                                    textColor =
                                        CustomColors().navigationTitleColor;
                                  }

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        page = number;
                                      });
                                    },
                                    child: Container(
                                      height: pageSelectionHeight,
                                      width: pageSelectionHeight,
                                      child: Center(
                                          child: Text(
                                            number.toString(),
                                            style: CustomTextStyles
                                                .textStyleTableColumn(context)
                                                ?.copyWith(color: textColor),
                                          )),
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
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: CustomColors().navigationIconColor,
                                ))
                          ],
                        ))
                  ],
                ));
          }
        });
  }
}
