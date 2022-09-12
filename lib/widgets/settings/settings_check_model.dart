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
    double tableWidth = (tableColumnWidth * 8) + 100;
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
                          height: 10,
                        ),
                        getListView(),
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

  Widget getListView() {
    if (segments.isEmpty) {
      return const SizedBox();
    } else {
      ///LIST VIEW OF SEGMENTS
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: segments.length,
          itemBuilder: (BuildContext context, int index) {
            TextEditingController n =
                TextEditingController(text: segments[index].name);
            TextEditingController d =
                TextEditingController(text: segments[index].description);
            TextEditingController h =
                TextEditingController(text: segments[index].help);

            segments[index].nameEditingController = n;
            segments[index].descriptionEditingController = d;
            segments[index].helpEditingController = h;

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
                                  onPressed: index == (segments.length - 1)
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
                            enabled: segments[index].edit,
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
                            enabled: segments[index].edit,
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
                            enabled: segments[index].edit,
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
                            getRowImages(index),
                            IconButton(
                              onPressed: segments[index].edit
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
                                          segments[index].images.add(path);
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
                          child: Checkbox(
                            checkColor: CustomColors().navigationTextColor,
                            activeColor: CustomColors().primaryColor,
                            value: segments[index].outside,
                            onChanged: (value) {
                              if (segments[index].edit) {
                                setState(() {
                                  segments[index].outside = value!;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: tableColumnWidth * 0.5,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (segments[index].edit) {
                                segments[index].name =
                                    segments[index].nameEditingController!.text;
                                segments[index].description = segments[index]
                                    .descriptionEditingController!
                                    .text;
                                segments[index].help =
                                    segments[index].helpEditingController!.text;
                              }
                              setState(() {
                                segments[index].edit = !segments[index].edit;
                              });
                            },
                            style: CustomButtonStyles.getStandardButtonStyle(),
                            child: Text(
                              segments[index].edit ? "SAVE" : "EDIT",
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
                  getRowImages(-1),
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
                          print(path);
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
              width: tableColumnWidth * 0.5,
              child: Center(
                child: Checkbox(
                  checkColor: CustomColors().navigationTextColor,
                  activeColor: CustomColors().primaryColor,
                  value: newRowOutside,
                  onChanged: (value) {
                    setState(() {
                      newRowOutside = value!;
                    });
                  },
                ),
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

  Widget getRowImages(int i) {
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
      if (segments[i].images.isEmpty) {
        return const SizedBox();
      } else {
        return ListView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: segments[i].images.length,
            itemBuilder: (BuildContext context, int index) {
              String imageText = "#" + (index + 1).toString();

              return Center(
                child: InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => DialogShowImage(
                            imagePath: segments[i].images[index]));
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
    temp.outside = newRowOutside;

    segments.add(temp);
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
}
