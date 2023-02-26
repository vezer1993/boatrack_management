import 'package:flutter/material.dart';

import '../../models/account.dart';
import '../../models/charter.dart';
import '../../resources/separators.dart';
import '../../resources/strings.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/button_styles.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';
import '../../services/accounts_api.dart';
import '../../services/charter_api.dart';
import '../containers/full_width_container.dart';

class SettingsAccountsWidget extends StatefulWidget {
  const SettingsAccountsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsAccountsWidget> createState() => _SettingsAccountsWidgetState();
}

class _SettingsAccountsWidgetState extends State<SettingsAccountsWidget> {
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

  bool inputEnabled = false;

  /// Text Controllers
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController pinTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCharterData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            double containerWidth =
                (itemCount * columnWidth) + firstColumnWidth;
            double containerHeight =
                (charter.accounts!.length * columnHeight) + headerHeight;
            double imageWidth = firstColumnWidth / 3;
            return FullWidthContainer(
                title: StaticStrings.getTeltonikaSettingsTitle(),
                childWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              itemCount: charter.accounts == null
                                  ? 1
                                  : charter.accounts!.length + 1,
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
                                                    child: Text("NAME",
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
                                                    child: Text("USERNAME",
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
                                                    child: Text("PIN",
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
                                                      charter
                                                          .accounts![index].name
                                                          .toString(),
                                                      style: CustomTextStyles
                                                          .textStyleTableHeader(
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
                                            child: Text(
                                                charter
                                                    .accounts![index].username
                                                    .toString(),
                                                style: CustomTextStyles
                                                    .textStyleTableColumn(
                                                        context),
                                                maxLines: 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: columnWidth * 2,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                                charter.accounts![index].pin
                                                    .toString(),
                                                style: CustomTextStyles
                                                    .textStyleTableColumn(
                                                        context),
                                                maxLines: 1),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            !charter.accounts![index].isAdmin!,
                                        child: Text("da"),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    Separators.dashboardVerticalSeparator(),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: containerWidth,
                          height: columnHeight,
                          decoration: CustomBoxDecorations.topAndBottomBorder(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// ADD NEW ACCOUNT
                              SizedBox(
                                width: firstColumnWidth,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextField(
                                      enabled: inputEnabled,
                                      controller: nameTextEditingController,
                                      style: CustomTextStyles
                                          .textStyleTableColumnNoBold(context),
                                      maxLines: 1,
                                      decoration: CustomBoxDecorations
                                              .getStandardInputDecoration(
                                                  context, inputEnabled)
                                          .copyWith(hintText: "Name"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth * 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextField(
                                      enabled: inputEnabled,
                                      controller: usernameTextEditingController,
                                      style: CustomTextStyles
                                          .textStyleTableColumnNoBold(context),
                                      maxLines: 1,
                                      decoration: CustomBoxDecorations
                                              .getStandardInputDecoration(
                                                  context, inputEnabled)
                                          .copyWith(hintText: "Username"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth * 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextField(
                                      enabled: inputEnabled,
                                      controller: passwordEditingController,
                                      style: CustomTextStyles
                                          .textStyleTableColumnNoBold(context),
                                      maxLines: 1,
                                      decoration: CustomBoxDecorations
                                              .getStandardInputDecoration(
                                                  context, inputEnabled)
                                          .copyWith(hintText: "Password"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth * 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextField(
                                      enabled: inputEnabled,
                                      controller: pinTextEditingController,
                                      style: CustomTextStyles
                                          .textStyleTableColumnNoBold(context),
                                      maxLines: 1,
                                      decoration: CustomBoxDecorations
                                              .getStandardInputDecoration(
                                                  context, inputEnabled)
                                          .copyWith(hintText: "PIN"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: columnWidth,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: !inputEnabled,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              inputEnabled = !inputEnabled;
                                            });
                                          },
                                          style: CustomButtonStyles
                                              .getStandardButtonStyle(),
                                          child: Text(
                                            StaticStrings.getButtonTextNew(),
                                            style: CustomTextStyles
                                                .getButtonTextStyle(context),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: inputEnabled,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            createUser();
                                          },
                                          style: CustomButtonStyles
                                              .getStandardButtonStyle(),
                                          child: Text(
                                            StaticStrings.buttonTextSave,
                                            style: CustomTextStyles
                                                .getButtonTextStyle(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          }
        });
  }

  void createUser() async {
    Accounts acc = Accounts();
    acc.charterId = charter.id;
    acc.charter = null;
    acc.name = nameTextEditingController.text;
    acc.password = passwordEditingController.text;
    acc.username = usernameTextEditingController.text;
    acc.isAdmin = false;
    acc.pin = pinTextEditingController.text;
    acc.cleanings = [];

    bool response = await postNewAccount(acc, context);
    if(response){
      updateCharter();
      setState(() {
        inputEnabled = !inputEnabled;
        nameTextEditingController.text = "";
        passwordEditingController.text = "";
        usernameTextEditingController.text = "";
        pinTextEditingController.text = "";
        charter.accounts!.add(acc);
      });
    }else{
    }
  }
}
