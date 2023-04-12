import 'package:boatrack_management/models/check_model.dart';
import 'package:boatrack_management/models/check_segment.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/values.dart';
import 'package:boatrack_management/services/models_api.dart';
import 'package:boatrack_management/widgets/containers/full_width_container.dart';
import 'package:boatrack_management/widgets/dialogs/dialog_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../resources/strings.dart';
import '../../resources/styles/button_styles.dart';
import '../../resources/styles/text_styles.dart';
import '../../services/azure.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SettingsCheckModelWidget extends StatefulWidget {
  const SettingsCheckModelWidget({Key? key}) : super(key: key);

  @override
  State<SettingsCheckModelWidget> createState() =>
      _SettingsCheckModelWidgetState();
}

class _SettingsCheckModelWidgetState extends State<SettingsCheckModelWidget> {
  bool isEditing = false;

  CheckModel selectedModel = CheckModel();
  List<CheckSegment> segments = [];

  List<CheckSegment> segmentsDeck = [];
  List<CheckSegment> segmentsSaloonCabin = [];
  List<CheckSegment> segmentsLocker = [];
  List<CheckSegment> segmentsKitchen = [];
  List<CheckSegment> segmentsEngine = [];
  List<CheckSegment> segmentsVarious = [];

  double tableColumnWidth = 150;
  double tableColumnHeight = StaticValues.halfContainerTableColumnHeight;
  double tableHeaderHeight = 40;

  TextEditingController modelNameEditingController = TextEditingController();

  /// NEW ROW EDITING
  TextEditingController newRowName = TextEditingController();
  TextEditingController newRowDescription = TextEditingController();
  TextEditingController newRowHelp = TextEditingController();
  List<String> newRowImages = [];
  bool newRowOutside = false;
  // Initial Selected Value
  String parentGroup = 'DECK';

  // List of items in our dropdown menu
  var parentGroupItems = [
    'DECK',
    'SALOON + CABINS',
    'LOCKERS',
    'KITCHEN',
    'ENGINE + EL. INSTAL.',
    'VARIOUS'
  ];

  ///EXISTING MODELS
  late List<CheckModel> futureData;
  bool dataLoaded = false;
  bool refreshData = false;

  Future getModelsListData() async {
    if (!dataLoaded) {
      if(refreshData == true){
        await Future.delayed(Duration(seconds: 1));
      }
      futureData = await getCheckModels();
      dataLoaded = true;
      refreshData = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    double tableWidth = (tableColumnWidth * 9) + 100;
    return Column(
      children: [
        FullWidthContainer(
          title: "MODELS",
          childWidget: Center(
              child: FutureBuilder(
            future: getModelsListData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text("NO CONNECTION");
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: (tableColumnHeight * futureData.length) +
                        tableHeaderHeight,
                    width: tableColumnWidth * 5,
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: futureData.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                              height: tableHeaderHeight,
                              width: tableColumnWidth * 5,
                              decoration:
                                  CustomBoxDecorations.tableHeaderContainer(),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: tableColumnWidth * 2,
                                      child: Padding(
                                        padding: StaticValues
                                            .standardTableItemPadding(),
                                        child: Center(
                                            child: Text("MODEL NAME",
                                                style: CustomTextStyles
                                                    .textStyleTableHeader(
                                                        context))),
                                      )),
                                ],
                              ),
                            );
                          } else {
                            index--;
                            return Container(
                              height: tableHeaderHeight,
                              width: tableColumnWidth * 5,
                              decoration:
                                  CustomBoxDecorations.topAndBottomBorder(),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: tableColumnWidth * 2,
                                    child: Padding(
                                      padding: StaticValues.standardTableItemPadding(),
                                      child: Center(
                                          child: Text(
                                              futureData[index]
                                                  .name
                                                  .toString(),
                                              style: CustomTextStyles
                                                  .textStyleTableHeader(
                                                  context))),
                                    ),),
                                  SizedBox(
                                      width: tableColumnWidth,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: futureData[index].charterId != null ? () {
                                              setState(() {
                                                selectedModel = futureData[index];
                                                segments = selectedModel.getModel();
                                                setAllSegments();
                                                modelNameEditingController.text = selectedModel.name.toString();
                                                isEditing = true;
                                              });
                                            } : null,
                                            style: CustomButtonStyles
                                                .getStandardButtonStyle(),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              child: Text(
                                                "Edit",
                                                style: CustomTextStyles
                                                    .getButtonTextStyle(
                                                    context),
                                              ),
                                            )),
                                      )),
                                  SizedBox(
                                      width: tableColumnWidth,
                                    child: Center(
                                      child: ElevatedButton(
                                          onPressed: futureData[index].charterId != null ? () async {
                                            await deleteCheckModel(futureData[index], context);
                                            setState(() {
                                              dataLoaded = false;
                                            });
                                          } : null,
                                          style: CustomButtonStyles
                                              .getStandardButtonStyle(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              "Delete",
                                              style: CustomTextStyles
                                                  .getButtonTextStyle(
                                                  context),
                                            ),
                                          )),
                                    ),),
                                  SizedBox(
                                      width: tableColumnWidth,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedModel = futureData[index];
                                                selectedModel.id = null;
                                                segments = selectedModel.getModel();
                                                setAllSegments();
                                                modelNameEditingController.text = selectedModel.name.toString();
                                                isEditing = true;
                                              });
                                            },
                                            style: CustomButtonStyles
                                                .getStandardButtonStyle(),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              child: Text(
                                                "New From",
                                                style: CustomTextStyles
                                                    .getButtonTextStyle(
                                                    context),
                                              ),
                                            )),
                                      )),
                                ],
                              ),
                            );
                          }
                        }),
                  ),
                );
              }
            },
          )),
        ),
        const SizedBox(
          height: 25,
        ),
        FullWidthContainer(
            title: "",
            childWidget: Center(
              child: Column(
                children: [
                  Visibility(
                    visible: !isEditing,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedModel = CheckModel();
                          segments = [];
                          modelNameEditingController.text = "";
                          isEditing = !isEditing;
                        });
                      },
                      style: CustomButtonStyles.getStandardButtonStyle(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        child: Text(
                          StaticStrings.getButtonTextNewModel(),
                          style: CustomTextStyles.getButtonTextStyle(context),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isEditing,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 400,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 400,
                                child: Center(
                                  child: TextField(
                                    controller: modelNameEditingController,
                                    style: CustomTextStyles.textStyleTitle(
                                        context),
                                    maxLines: 1,
                                    decoration: CustomBoxDecorations
                                            .getStandardInputDecoration(
                                                context, true)
                                        .copyWith(
                                            labelText: "Model Name",
                                            labelStyle: CustomTextStyles
                                                .textStyleTableDescription(
                                                    context)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("DECK", style: CustomTextStyles.textStyleTitle(context)),
                        const SizedBox(height: 2,),
                        getListView(segmentsDeck),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                          child: Container(width: double.infinity, height: 2, color: CustomColors().primaryColor,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("SALOON & CABIN", style: CustomTextStyles.textStyleTitle(context)),
                        const SizedBox(height: 2,),
                        getListView(segmentsSaloonCabin),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                          child: Container(width: double.infinity, height: 2, color: CustomColors().primaryColor,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("LOCKERS", style: CustomTextStyles.textStyleTitle(context)),
                        const SizedBox(height: 2,),
                        getListView(segmentsLocker),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                          child: Container(width: double.infinity, height: 2, color: CustomColors().primaryColor,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("KITCHEN", style: CustomTextStyles.textStyleTitle(context)),
                        const SizedBox(height: 2,),
                        getListView(segmentsKitchen),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                          child: Container(width: double.infinity, height: 2, color: CustomColors().primaryColor,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("ENGINE & EL. INSTAL.", style: CustomTextStyles.textStyleTitle(context)),
                        const SizedBox(height: 2,),
                        getListView(segmentsEngine),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                          child: Container(width: double.infinity, height: 2, color: CustomColors().primaryColor,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("VARIOUS", style: CustomTextStyles.textStyleTitle(context)),
                        const SizedBox(height: 2,),
                        getListView(segmentsVarious),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                          child: Container(width: double.infinity, height: 2, color: CustomColors().primaryColor,),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "NEW SEGMENT",
                          style: CustomTextStyles.textStyleTitle(context),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                              width: tableWidth,
                              height: tableColumnHeight,
                              child: getSegmentRow(null)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              selectedModel.setModel(segments);
                              if(selectedModel.id != null){
                                await updateCheckModel();
                              }else{
                                futureData.add(selectedModel);
                                await createCheckModel();
                              }
                              selectedModel = CheckModel();
                              dataLoaded = false;
                              setState(() {
                                isEditing = !isEditing;
                              });
                            },
                            style: CustomButtonStyles.getStandardButtonStyle(),
                            child: Text(
                              "SAVE",
                              style:
                                  CustomTextStyles.getButtonTextStyle(context)
                                      ?.copyWith(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget getListView(List<CheckSegment> segmentParts) {

    if (segmentParts.isEmpty) {
      return const SizedBox();
    } else {
      ///LIST VIEW OF SEGMENTS
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: segmentParts.length,
          itemBuilder: (BuildContext context, int index) {
            TextEditingController n =
                TextEditingController(text: segmentParts[index].name);
            TextEditingController d =
                TextEditingController(text: segmentParts[index].description);
            TextEditingController h =
                TextEditingController(text: segmentParts[index].help);

            segmentParts[index].nameEditingController = n;
            segmentParts[index].descriptionEditingController = d;
            segmentParts[index].helpEditingController = h;

            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: (tableColumnWidth * 8) + 100,
                  decoration: CustomBoxDecorations.topAndBottomBorder(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: index == 0
                                      ? null
                                      : () {
                                          setState(() {
                                            moveSegmentInList(index, -1);
                                          });
                                        },
                                  icon: Icon(
                                    Icons.arrow_upward,
                                    color: CustomColors().navigationIconColor,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  onPressed: index == (segmentParts.length - 1)
                                      ? null
                                      : () {
                                          setState(() {
                                            moveSegmentInList(index, 1);
                                          });
                                        },
                                  icon: Icon(Icons.arrow_downward,
                                      color:
                                          CustomColors().navigationIconColor),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                )
                              ],
                            ),
                            Text(
                              (index + 1).toString(),
                              style:
                                  CustomTextStyles.textStyleTableHeader(context)
                                      ?.copyWith(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: tableColumnWidth * 1,
                        child: Center(
                          child: TextField(
                            controller: n,
                            enabled: segmentParts[index].edit,
                            style: CustomTextStyles.textStyleTableColumnNoBold(
                                context),
                            maxLines: 1,
                            decoration: CustomBoxDecorations
                                    .getStandardInputDecoration(context, true)
                                .copyWith(
                                    labelText: "NAME",
                                    labelStyle: CustomTextStyles
                                        .textStyleTableDescription(context)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: tableColumnWidth * 3,
                        child: Center(
                          child: TextField(
                            controller: d,
                            enabled: segmentParts[index].edit,
                            style: CustomTextStyles.textStyleTableColumnNoBold(
                                context),
                            maxLines: 1,
                            decoration: CustomBoxDecorations
                                    .getStandardInputDecoration(context, true)
                                .copyWith(
                                    labelText: "DESCRIPTION",
                                    labelStyle: CustomTextStyles
                                        .textStyleTableDescription(context)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: tableColumnWidth * 1,
                        child: Center(
                          child: TextField(
                            controller: h,
                            enabled: segmentParts[index].edit,
                            style: CustomTextStyles.textStyleTableColumnNoBold(
                                context),
                            maxLines: 1,
                            decoration: CustomBoxDecorations
                                    .getStandardInputDecoration(context, true)
                                .copyWith(
                                    labelText: "HELP",
                                    labelStyle: CustomTextStyles
                                        .textStyleTableDescription(context)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: tableColumnWidth * 1,
                        height: tableColumnHeight,
                        child: Center(
                            child: Row(
                          children: [
                            getRowImages(segmentParts[index], 0),
                            IconButton(
                              onPressed: segmentParts[index].edit
                                  ? () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'jpg',
                                          'png',
                                          'jpeg'
                                        ],
                                      );
                                      if (result != null) {
                                        String path = await uploadImageToAzure(
                                            context,
                                            result.files[0].name.toString(),
                                            result.files[0].extension
                                                .toString(),
                                            result.files[0].bytes!);
                                        setState(() {
                                          segmentParts[index].images.add(path);
                                        });
                                      }
                                    }
                                  : null,
                              icon: Icon(Icons.upload_file),
                              tooltip: "UPLOAD",
                              color: CustomColors().navigationIconColor,
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        width: tableColumnWidth * 0.5,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (segmentParts[index].edit) {
                                segmentParts[index].name =
                                    segmentParts[index].nameEditingController!.text;
                                segmentParts[index].description = segmentParts[index]
                                    .descriptionEditingController!
                                    .text;
                                segmentParts[index].help =
                                    segmentParts[index].helpEditingController!.text;
                              }
                              setState(() {
                                segmentParts[index].edit = !segmentParts[index].edit;
                              });
                            },
                            style: CustomButtonStyles.getStandardButtonStyle(),
                            child: Text(
                              segmentParts[index].edit ? "SAVE" : "EDIT",
                              style:
                                  CustomTextStyles.getButtonTextStyle(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  /// NEW ROW SEGMENT ONLY
  Widget getSegmentRow(CheckSegment? s) {
    if (s == null) {
      return Container(
        decoration: CustomBoxDecorations.topAndBottomBorder(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 50,
            ),
            SizedBox(
              width: tableColumnWidth * 1,
              child: Center(
                child: TextField(
                  controller: newRowName,
                  style: CustomTextStyles.textStyleTableColumnNoBold(context),
                  maxLines: 1,
                  decoration: CustomBoxDecorations.getStandardInputDecoration(
                          context, true)
                      .copyWith(
                          labelText: "NAME",
                          labelStyle:
                              CustomTextStyles.textStyleTableDescription(
                                  context)),
                ),
              ),
            ),
            SizedBox(
              width: tableColumnWidth * 3,
              child: Center(
                child: TextField(
                  controller: newRowDescription,
                  style: CustomTextStyles.textStyleTableColumnNoBold(context),
                  maxLines: 1,
                  decoration: CustomBoxDecorations.getStandardInputDecoration(
                          context, true)
                      .copyWith(
                          labelText: "DESCRIPTION",
                          labelStyle:
                              CustomTextStyles.textStyleTableDescription(
                                  context)),
                ),
              ),
            ),
            SizedBox(
              width: tableColumnWidth * 1,
              child: Center(
                child: TextField(
                  controller: newRowHelp,
                  style: CustomTextStyles.textStyleTableColumnNoBold(context),
                  maxLines: 1,
                  decoration: CustomBoxDecorations.getStandardInputDecoration(
                          context, true)
                      .copyWith(
                          labelText: "HELP",
                          labelStyle:
                              CustomTextStyles.textStyleTableDescription(
                                  context)),
                ),
              ),
            ),
            SizedBox(
              width: tableColumnWidth * 1,
              child: Center(
                  child: Row(
                children: [
                  getRowImages(null, -1),
                  IconButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png', 'jpeg'],
                      );
                      if (result != null) {
                        String path = await uploadImageToAzure(
                            context,
                            result.files[0].name.toString(),
                            result.files[0].extension.toString(),
                            result.files[0].bytes!);
                        setState(() {
                          newRowImages.add(path);
                        });
                      }
                    },
                    icon: Icon(Icons.upload_file),
                    tooltip: "UPLOAD",
                    color: CustomColors().navigationIconColor,
                  ),
                ],
              )),
            ),
            SizedBox(
              width: tableColumnWidth * 2,
              child: DropdownButton2(
                hint: Text(
                  'Select Group',
                  style: CustomTextStyles.textStyleTableColumn(context),
                ),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColors().websiteBackgroundColor,
                ),
                items: parentGroupItems
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: CustomTextStyles.textStyleTableColumn(
                        context),
                  ),
                ))
                    .toList(),
                value: parentGroup,
                onChanged: (value) {
                  setState(() {
                    parentGroup = value.toString();
                  });
                },
                buttonHeight: 50,
                buttonWidth: 300,
                itemHeight: 40,
              ),
            ),
            SizedBox(
              width: tableColumnWidth * 0.5,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addNewSegmentRow();
                    });
                  },
                  style: CustomButtonStyles.getStandardButtonStyle(),
                  child: Text(
                    "ADD",
                    style: CustomTextStyles.getButtonTextStyle(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget getRowImages(CheckSegment? seg, int i) {
    if (i == -1) {
      if (newRowImages.isEmpty) {
        return const SizedBox();
      } else {
        return ListView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: newRowImages.length,
            itemBuilder: (BuildContext context, int index) {
              String imageText = "#" + (index + 1).toString();

              return Center(
                child: InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) =>
                            DialogShowImage(imagePath: newRowImages[index]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      imageText,
                      style: CustomTextStyles.textStyleTableColumn(context),
                    ),
                  ),
                ),
              );
            });
      }
    } else {
      if (seg!.images.isEmpty) {
        return const SizedBox();
      } else {
        return ListView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: seg!.images.length,
            itemBuilder: (BuildContext context, int index) {
              String imageText = "#" + (index + 1).toString();

              return Center(
                child: InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => DialogShowImage(
                            imagePath: seg!.images[index]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      imageText,
                      style: CustomTextStyles.textStyleTableColumn(context),
                    ),
                  ),
                ),
              );
            });
      }
    }
  }

  addNewSegmentRow() {
    CheckSegment temp = CheckSegment();

    temp.name = newRowName.text.toString();
    temp.description = newRowDescription.text.toString();
    temp.help = newRowHelp.text.toString();
    temp.images = newRowImages;
    temp.parentGroup = parentGroup;
    print(parentGroup);

    segments.add(temp);
    setAllSegments();
    emptyNewRow();
  }

  emptyNewRow() {
    newRowName.text = "";
    newRowDescription.text = "";
    newRowHelp.text = "";
    newRowImages = [];
    newRowOutside = false;
  }

  moveSegmentInList(int index, int direction) {
    CheckSegment seg = segments[index];
    segments.removeAt(index);
    segments.insert(index + direction, seg);
  }

  createCheckModel() async {
    selectedModel.name = modelNameEditingController.text;
    postNewCheckModel(selectedModel, context);
  }

  updateCheckModel() async {
    selectedModel.name = modelNameEditingController.text;
    putCheckModel(selectedModel, context);
  }

  void setAllSegments() {

    segmentsDeck = [];
    segmentsSaloonCabin = [];
    segmentsLocker = [];
    segmentsKitchen = [];
    segmentsEngine = [];
    segmentsVarious = [];

    for(CheckSegment seg in segments){
      if(seg.parentGroup == "DECK"){
        segmentsDeck.add(seg);
      }else if (seg.parentGroup == "SALOON + CABINS"){
        segmentsSaloonCabin.add(seg);
      }else if (seg.parentGroup == "LOCKERS"){
        segmentsLocker.add(seg);
      }else if (seg.parentGroup == "KITCHEN"){
        segmentsKitchen.add(seg);
      }else if (seg.parentGroup == "ENGINE + EL. INSTAL."){
        segmentsEngine.add(seg);
      }else if (seg.parentGroup == "VARIOUS"){
        segmentsVarious.add(seg);
      }

    }
  }
}