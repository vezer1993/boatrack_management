import 'package:boatrack_management/models/yacht.dart';
import 'package:boatrack_management/resources/separators.dart';
import 'package:boatrack_management/resources/strings.dart';
import 'package:boatrack_management/resources/styles/button_styles.dart';
import 'package:boatrack_management/services/charter_api.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:flutter/material.dart';

import '../../models/charter.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';
import '../containers/full_width_container.dart';

class SettingsTeltonikaWidget extends StatefulWidget {
  final List<Yacht> yachts;

  const SettingsTeltonikaWidget({Key? key, required this.yachts})
      : super(key: key);

  @override
  State<SettingsTeltonikaWidget> createState() =>
      _SettingsTeltonikaWidgetState();
}

class _SettingsTeltonikaWidgetState extends State<SettingsTeltonikaWidget> {
  ///FUTURE DATA
  late Charter charter;
  bool dataLoaded = false;

  Future getCharterData() async {
    if (!dataLoaded) {
      charter = await getCharter();
      dataLoaded = true;
    }
    return charter;
  }

  ///Measures
  double headerHeight = StaticValues.halfContainerTableHeaderHeight;
  double columnWidth = StaticValues.halfContainerTableColumnWidth;
  double firstColumnWidth = StaticValues.halfContainerTableFirstColumnWidth;
  double columnHeight = StaticValues.halfContainerTableColumnHeightNoPicture;
  double itemCount = 7;

  ///Input variables
  bool charterInputEnabled = false;
  TextEditingController charterTextEditingController = TextEditingController();
  List<bool> inputsEnabled = [];
  List<TextEditingController> editingControllers = [];

  @override
  Widget build(BuildContext context) {
    ///CALCULATIONS
    double containerWidth = (itemCount * columnWidth) + firstColumnWidth;
    double containerHeight =
        (widget.yachts.length * columnHeight) + headerHeight;
    double imageWidth = firstColumnWidth / 3;

    return FutureBuilder(
        future: getCharterData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return FullWidthContainer(
                title: StaticStrings.getTeltonikaSettingsTitle(),
                childWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Separators.dashboardVerticalSeparator(),
                    SizedBox(
                      width: containerWidth,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "CHARTER",
                            style:
                                CustomTextStyles.textStyleTableHeader(context),
                          )),
                    ),
                    Separators.dashboardVerticalSeparator(),
                    /// CHARTER
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: containerWidth,
                        height: columnHeight,
                        decoration: CustomBoxDecorations.topAndBottomBorder(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: firstColumnWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: firstColumnWidth - imageWidth,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(charter.name.toString(),
                                            style: CustomTextStyles
                                                .textStyleTableHeader(context)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: columnWidth * 2,
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SelectableText(charter.teltonikaToken.toString(),
                                      style: CustomTextStyles.textStyleTableColumn(
                                          context), maxLines: 1),
                                ),
                              ),
                            ),
                            //input
                            SizedBox(
                              width: columnWidth * 2,
                              child: Center(
                                child: TextField(
                                  enabled: charterInputEnabled,
                                  controller: charterTextEditingController,
                                  style:
                                      CustomTextStyles.textStyleTableColumnNoBold(
                                          context),
                                  maxLines: 1,
                                  decoration: CustomBoxDecorations
                                      .getStandardInputDecoration(
                                          context, charterInputEnabled),
                                ),
                              ),
                            ),
                            //buttons
                            SizedBox(
                              width: columnWidth * 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                      visible: !charterInputEnabled,
                                      //edit
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            charterInputEnabled =
                                                !charterInputEnabled;
                                          });
                                        },
                                        style: CustomButtonStyles
                                            .getStandardButtonStyle(),
                                        child: Text(
                                          StaticStrings.getButtonTextEdit(),
                                          style:
                                              CustomTextStyles.getButtonTextStyle(
                                                  context),
                                        ),
                                      )),
                                  Visibility(
                                      visible: charterInputEnabled,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //cancel
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                charterTextEditingController.text = "";
                                                charterInputEnabled =
                                                    !charterInputEnabled;
                                              });
                                            },
                                            style: CustomButtonStyles
                                                .getStandardButtonStyle(),
                                            child: Text(
                                              StaticStrings.getButtonTextCancel(),
                                              style: CustomTextStyles
                                                  .getButtonTextStyle(context),
                                            ),
                                          ),
                                          Separators
                                              .dashboardHorizontalSeparator(),
                                          //save
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                updateCharterTeltonikaID();
                                              });
                                            },
                                            style: CustomButtonStyles
                                                .getStandardButtonStyle(),
                                            child: Text(
                                              StaticStrings.getButtonTextSave(),
                                              style: CustomTextStyles
                                                  .getButtonTextStyle(context),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Separators.dashboardVerticalSeparator(),
                    Separators.dashboardVerticalSeparator(),
                    SizedBox(
                      width: containerWidth,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StaticStrings.getDashboardYachtListTitle().toUpperCase(),
                            style:
                            CustomTextStyles.textStyleTableHeader(context),
                          )),
                    ),
                    Separators.dashboardVerticalSeparator(),
                    /// YACHTS
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: containerHeight,
                          width: containerWidth,
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.yachts == null
                                  ? 1
                                  : widget.yachts.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  // return the header
                                  return Container(
                                      width: containerWidth,
                                      height: headerHeight,
                                      decoration: CustomBoxDecorations
                                          .tableHeaderContainer(),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: firstColumnWidth,
                                              child: Padding(
                                                padding: StaticValues
                                                    .standardTableItemPadding(),
                                                child: Center(
                                                    child: Text("YACHT",
                                                        style: CustomTextStyles
                                                            .textStyleTableHeader(
                                                                context))),
                                              )),
                                          SizedBox(
                                              width: columnWidth * 2,
                                              child: Padding(
                                                padding: StaticValues
                                                    .standardTableItemPadding(),
                                                child: Center(
                                                    child: Text("TELTONIKA ID",
                                                        style: CustomTextStyles
                                                            .textStyleTableHeader(
                                                                context))),
                                              )),
                                          SizedBox(
                                              width: columnWidth * 2,
                                              child: Padding(
                                                padding: StaticValues
                                                    .standardTableItemPadding(),
                                                child: Center(
                                                    child: Text("INPUT",
                                                        style: CustomTextStyles
                                                            .textStyleTableHeader(
                                                                context))),
                                              )),
                                          SizedBox(
                                              width: columnWidth * 2,
                                              child: Padding(
                                                padding: StaticValues
                                                    .standardTableItemPadding(),
                                                child: Center(
                                                    child: Text("",
                                                        style: CustomTextStyles
                                                            .textStyleTableHeader(
                                                                context))),
                                              )),
                                        ],
                                      ));
                                }
                                index -= 1;

                                if (inputsEnabled.length <
                                    widget.yachts.length) {
                                  editingControllers
                                      .add(TextEditingController());
                                  inputsEnabled.add(false);
                                }

                                return Container(
                                  width: containerWidth,
                                  height: columnHeight,
                                  decoration:
                                      CustomBoxDecorations.topAndBottomBorder(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///HEADER
                                      SizedBox(
                                        width: firstColumnWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width:
                                                  firstColumnWidth - imageWidth,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      widget.yachts[index].name
                                                          .toString(),
                                                      style: CustomTextStyles
                                                          .textStyleTableHeader(
                                                              context)),
                                                  Text(
                                                      widget.yachts[index].model
                                                          .toString(),
                                                      style: CustomTextStyles
                                                          .textStyleTableDescription(
                                                              context)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 2,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: SelectableText(widget.yachts[index].teltonikaId
                                                .toString(),
                                                style: CustomTextStyles.textStyleTableColumn(
                                                    context), maxLines: 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 2,
                                        child: Center(
                                          child: TextField(
                                            enabled: inputsEnabled[index],
                                            controller:
                                                editingControllers[index],
                                            style: CustomTextStyles
                                                .textStyleTableColumnNoBold(
                                                    context),
                                            maxLines: 1,
                                            decoration: CustomBoxDecorations
                                                .getStandardInputDecoration(
                                                    context,
                                                    inputsEnabled[index]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 3,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //edit
                                            Visibility(
                                                visible: !inputsEnabled[index],
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      inputsEnabled[index] =
                                                          !inputsEnabled[index];
                                                    });
                                                  },
                                                  style: CustomButtonStyles
                                                      .getStandardButtonStyle(),
                                                  child: Text(
                                                    StaticStrings
                                                        .getButtonTextEdit(),
                                                    style: CustomTextStyles
                                                        .getButtonTextStyle(
                                                            context),
                                                  ),
                                                )),
                                            //save & cancel
                                            Visibility(
                                                visible: inputsEnabled[index],
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    //cancel
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          editingControllers[index].text = "";
                                                          inputsEnabled[index] =
                                                              !inputsEnabled[
                                                                  index];
                                                        });
                                                      },
                                                      style: CustomButtonStyles
                                                          .getStandardButtonStyle(),
                                                      child: Text(
                                                        StaticStrings
                                                            .getButtonTextCancel(),
                                                        style: CustomTextStyles
                                                            .getButtonTextStyle(
                                                                context),
                                                      ),
                                                    ),
                                                    Separators
                                                        .dashboardHorizontalSeparator(),
                                                    //save
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        updateYachtTeltonikaID(widget.yachts[index].id!, index);
                                                      },
                                                      style: CustomButtonStyles
                                                          .getStandardButtonStyle(),
                                                      child: Text(
                                                        StaticStrings
                                                            .getButtonTextSave(),
                                                        style: CustomTextStyles
                                                            .getButtonTextStyle(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ));
          }
        });
  }

  Future updateCharterTeltonikaID() async{
    bool updated = await putCharterTeltonikaID(charter.id!, charterTextEditingController.text, context);

    if(updated){
      setState(() {
        charter.teltonikaToken = charterTextEditingController.text;
        charterTextEditingController.text = "";
        charterInputEnabled = !charterInputEnabled;
      });
    }
  }

  Future updateYachtTeltonikaID(int yachtID, int index) async{
    bool updated = await putYachtTeltonikaID(yachtID, editingControllers[index].text, context);

    if(updated){
      setState(() {
        widget.yachts[index].teltonikaId = editingControllers[index].text;
        editingControllers[index].text = "";
        inputsEnabled[index] = !inputsEnabled[index];
      });
    }
  }
}
