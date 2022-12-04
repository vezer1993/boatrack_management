import 'dart:html' as html;

import 'package:boatrack_management/helpers/conversions.dart';
import 'package:boatrack_management/models/account.dart';
import 'package:boatrack_management/models/issues.dart';
import 'package:boatrack_management/services/accounts_api.dart';
import 'package:boatrack_management/widgets/user_interface/gallery_widget.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import '../../models/yacht.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import 'package:file_picker/file_picker.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/button_styles.dart';
import '../../resources/styles/text_styles.dart';
import '../../services/azure.dart';
import '../../services/issues_api.dart';
import '../../services/yachts_api.dart';

class DialogIssueExplorer extends StatefulWidget {
  final String issueID;

  const DialogIssueExplorer({Key? key, required this.issueID})
      : super(key: key);

  @override
  State<DialogIssueExplorer> createState() => _DialogIssueExplorerState();
}

class _DialogIssueExplorerState extends State<DialogIssueExplorer> {
  bool dataLoaded = false;
  IssueItem? issue;
  Yacht? yacht;
  Accounts? employee;
  String? document;

  TextEditingController resolveNoteEditingController = TextEditingController();

  Future getIssueData() async {
    if (!dataLoaded) {
      issue = await getIssueForID(widget.issueID);
      yacht = await getYachtForID(issue!.yachtId!);
      employee = await getSelectedUser(issue!.accountID!);
      dataLoaded = true;
    }
    return issue;
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

    return Dialog(
        child: Container(
      width: containerWidth,
      height: containerHeight,
      color: CustomColors().websiteBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getIssueData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text("NO CONNECTION");
              } else if (!snapshot.hasData ||
                  yacht == null ||
                  issue == null ||
                  employee == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        yacht!.name.toString() +
                            " ISSUE " +
                            Conversion.convertISOTimeToStandardFormat(
                                issue!.timestamp!),
                        style: CustomTextStyles.textStyleCharterName(context),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: CustomColors().altBackgroundColor,
                          boxShadow: [
                            CustomBoxDecorations.containerBoxShadow()
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            issue!.name.toString(),
                            style: CustomTextStyles.textStyleTitle(context),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                Conversion
                                    .convertISOTimeToStandardFormatWithTime(
                                        issue!.timestamp!),
                                style: CustomTextStyles.textStyleTableHeader(
                                        context)
                                    ?.copyWith(
                                        color: CustomColors().primaryColor)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 1, left: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().primaryColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "REPORTED BY",
                              style: CustomTextStyles.textStyleTableHeader(
                                  context),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                employee!.name.toString(),
                                style: CustomTextStyles.textStyleTableColumn(
                                    context),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 1, left: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().primaryColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "DESCRIPTION",
                              style: CustomTextStyles.textStyleTableHeader(
                                  context),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                issue!.description.toString(),
                                style: CustomTextStyles.textStyleTableColumn(
                                    context),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 1, left: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().primaryColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "PICTURES",
                              style: CustomTextStyles.textStyleTableHeader(
                                  context),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Visibility(
                              visible: issue!.hasPictures!,
                              child:
                                  GalleryWidget(images: issue!.getImageList())),
                          Visibility(
                            visible: !issue!.hasPictures!,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "No pictures",
                                  style: CustomTextStyles.textStyleTableColumn(
                                      context),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: !issue!.resolved!,
                      child: ExpandableTheme(
                        data: ExpandableThemeData(
                            iconColor: CustomColors().primaryColor,
                            hasIcon: false,
                            alignment: Alignment.center,
                            animationDuration:
                                const Duration(milliseconds: 500)),
                        child: ExpandablePanel(
                          header: Container(
                            decoration:
                                CustomBoxDecorations.standardBoxDecoration(),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                    "RESOLVE ISSUE",
                                    style: CustomTextStyles.textStyleTitle(
                                        context),
                                  )),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_downward,
                                    size: 20,
                                    color: CustomColors().primaryColor,
                                  )
                                ],
                              ),
                            )),
                          ),
                          collapsed: const SizedBox(),
                          expanded: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              width: double.infinity,
                              decoration:
                                  CustomBoxDecorations.standardBoxDecoration(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 15, 25, 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Center(
                                          child: TextField(
                                            controller:
                                                resolveNoteEditingController,
                                            style: CustomTextStyles
                                                .textStyleTableColumnNoBold(
                                                    context),
                                            minLines: 3,
                                            maxLines: 5,
                                            decoration: CustomBoxDecorations
                                                    .getStandardInputDecoration(
                                                        context, true)
                                                .copyWith(
                                                    hintText:
                                                        "RESOLUTION NOTE"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Visibility(
                                      visible: document == null,
                                      child: SizedBox(
                                        width: 175,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles();
                                            if (result != null) {
                                              String path =
                                                  await uploadDocumentToAzure(
                                                      context,
                                                      result.files[0].name
                                                          .toString(),
                                                      result.files[0].extension
                                                          .toString(),
                                                      result.files[0].bytes!);
                                              setState(() {
                                                document = path;
                                              });
                                            }
                                          },
                                          style: CustomButtonStyles
                                              .getStandardButtonStyle(),
                                          child: Text(
                                            "ATTACH DOCUMENT",
                                            style: CustomTextStyles
                                                .getButtonTextStyle(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: document != null,
                                      child: const Text("ADDED"),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: SizedBox(
                                          width: 250,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              document ??= "null";
                                              bool success =
                                                  await putIssueResolve(
                                                      issue!.id.toString(),
                                                      document!,
                                                      resolveNoteEditingController
                                                          .text,
                                                      context);

                                              if (success) {
                                                dataLoaded = false;
                                                setState(() {});
                                              }
                                            },
                                            style: CustomButtonStyles
                                                .getStandardButtonStyle(),
                                            child: Text(
                                              "RESOLVE",
                                              style: CustomTextStyles
                                                  .getButtonTextStyle(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: issue!.resolved!,
                        child: Container(
                          width: double.infinity,
                          decoration:
                              CustomBoxDecorations.standardBoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "RESOLUTION",
                                  style: CustomTextStyles.textStyleTitle(context),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 1, left: 2, right: 2),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: CustomColors().primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "RESOLUTION NOTE",
                                    style: CustomTextStyles.textStyleTableHeader(
                                        context),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      issue!.resolutionNote.toString(),
                                      style:
                                          CustomTextStyles.textStyleTableColumn(
                                              context),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 1, left: 2, right: 2),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: CustomColors().primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "DOCUMENT",
                                    style: CustomTextStyles.textStyleTableHeader(
                                        context),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: InkWell(
                                      onTap: () {
                                        downloadFile(issue!.document.toString());
                                      },
                                      child: Text(
                                        "download",
                                        style: CustomTextStyles
                                                .textStyleTableColumn(context)
                                            ?.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                color:
                                                    CustomColors().primaryColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    ));
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}
