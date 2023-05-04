import 'package:boatrack_management/models/yacht.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/box_decorations.dart';
import '../../resources/styles/text_styles.dart';
import '../../resources/values.dart';
import '../../services/yachts_api.dart';
import '../containers/full_width_container.dart';

class SettingsYachtVisibilityWidget extends StatefulWidget {
  const SettingsYachtVisibilityWidget({Key? key}) : super(key: key);

  @override
  State<SettingsYachtVisibilityWidget> createState() =>
      _SettingsYachtVisibilityWidgetState();
}

class _SettingsYachtVisibilityWidgetState
    extends State<SettingsYachtVisibilityWidget> {
  late List<Yacht> yachts;
  bool dataLoaded = false;

  Future getYachtData() async {
    if (!dataLoaded) {
      yachts = await getYachtListALL();
      dataLoaded = true;
    }
    return yachts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getYachtData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return FullWidthContainer(
              title: 'YACHT VISIBILITY', childWidget: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: yachts == null
                    ? 1
                    : yachts.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    // return the header
                    return Container(
                        width: 240,
                        height: 50,
                        decoration: CustomBoxDecorations
                            .tableHeaderContainer(),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 120,
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
                                width: 120,
                                child: Padding(
                                  padding: StaticValues
                                      .standardTableItemPadding(),
                                  child: Center(
                                      child: Text("VISIBLE",
                                          style: CustomTextStyles
                                              .textStyleTableHeader(
                                              context))),
                                )),
                          ],
                        ));
                  }
                  index -= 1;

                  if (yachts[index].visible == null) {
                    yachts[index].visible = false;
                  }

                  return Container(
                    width: 240,
                    height: 60,
                    decoration:
                    CustomBoxDecorations.topAndBottomBorder(),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [

                        ///HEADER
                        SizedBox(
                            width: 120,
                            child: Center(child: Text(yachts[index].name.toString(), style: CustomTextStyles.textStyleTableColumn(context),),)
                        ),
                        SizedBox(
                          width: 120,
                          child: Center(
                              child: Switch(
                                onChanged: (value) async{
                                  await putYachtVisibility(yachts[index].id!, value, context);
                                  setState(() {
                                    yachts[index].visible = value;
                                  });
                                },
                                value: yachts[index].visible!,
                                activeColor: Colors.green,
                                inactiveThumbColor: Colors.redAccent,
                              )
                          ),
                        ),
                      ],
                    ),
                  );
                }),);
          }
        });
  }
}
