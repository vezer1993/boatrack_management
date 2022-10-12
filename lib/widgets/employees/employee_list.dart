import 'package:boatrack_management/models/account.dart';
import 'package:boatrack_management/services/accounts_api.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';

class EmployeeListWidget extends StatefulWidget {
  final int selectedEmployee;
  final Function notifyParent;

  const EmployeeListWidget({Key? key, required this.selectedEmployee, required this.notifyParent})
      : super(key: key);

  @override
  State<EmployeeListWidget> createState() => _EmployeeListWidgetState();
}

class _EmployeeListWidgetState extends State<EmployeeListWidget> {
  late List<Accounts> futureData;
  bool dataLoaded = false;

  Future getEmployeeList() async {
    if (!dataLoaded) {
      futureData = await getUserList();
      dataLoaded = true;
    }
    return futureData;
  }

  double pageSelectionHeight = 50;
  double columnWidth = 130;
  double columnHeight = 37;

  double containerHeight = 250;

  int itemsPerPage = 4;
  int page = 1;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEmployeeList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {

            int pageCount = (futureData.length / 4).ceil();

            return SizedBox(
                height: containerHeight,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: columnWidth * 6,
                        height: containerHeight - pageSelectionHeight,
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
                                        width: columnWidth * 2,
                                        child: Padding(
                                          padding: StaticValues
                                              .standardTableItemPadding(),
                                          child: Center(
                                              child: Text("NAME",
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
                                              child: Text("USERNAME",
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
                                              child: Text(
                                                "PIN",
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
                                              child: Text("ROLES",
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
                                  futureData.length) {
                                int i = index + ((page - 1) * itemsPerPage);

                                Accounts a = futureData[i];

                                Color backgroundColor = Colors.transparent;

                                if(widget.selectedEmployee == a.id){
                                    backgroundColor = CustomColors().selectedItemColor;
                                }

                                return InkWell(
                                  onTap: () {
                                    widget.notifyParent(a.id);
                                  },
                                  child: Container(
                                    width: columnWidth * 5,
                                    height: (containerHeight -
                                        columnHeight -
                                        pageSelectionHeight) /
                                        itemsPerPage,
                                    decoration:
                                    CustomBoxDecorations.topAndBottomBorder().copyWith(color: backgroundColor),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: columnWidth * 2,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                                child: Text(a.name.toString(),
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
                                              child: Text(a.username.toString(),
                                                  style: CustomTextStyles
                                                      .textStyleTableColumn(
                                                      context)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: columnWidth,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                                child: Text(
                                                  a.pin.toString(),
                                                  style: CustomTextStyles
                                                      .textStyleTableColumn(context),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: columnWidth,
                                          child: Padding(
                                            padding: StaticValues
                                                .standardTableItemPadding(),
                                            child: Center(
                                                child: Text("TODO",
                                                    style: CustomTextStyles
                                                        .textStyleTableColumn(
                                                        context))),
                                          ),
                                        )
                                      ],
                                    ),
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
