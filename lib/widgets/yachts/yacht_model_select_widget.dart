import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../models/check_model.dart';
import '../../models/yacht.dart';
import '../../resources/strings.dart';
import '../../resources/styles/button_styles.dart';
import '../../services/models_api.dart';
import '../../services/yachts_api.dart';

class YachtModelSelectWidget extends StatefulWidget {
  final Yacht yacht;

  const YachtModelSelectWidget({Key? key, required this.yacht})
      : super(key: key);

  @override
  State<YachtModelSelectWidget> createState() => _YachtModelSelectWidgetState();
}

class _YachtModelSelectWidgetState extends State<YachtModelSelectWidget> {
  late List<CheckModel> futureData;
  CheckModel? selectedDropDownValue;
  bool dataLoaded = false;
  bool refreshData = false;

  bool dropDownEnabled = false;

  Future getModelsListData() async {
    if (!dataLoaded) {
      if (refreshData == true) {
        await Future.delayed(Duration(seconds: 1));
      }
      futureData = await getCheckModels();
      if (widget.yacht.checkModelId != null) {
        for (CheckModel cm in futureData) {
          if (cm.id == widget.yacht.checkModelId) {
            selectedDropDownValue = cm;
          }
        }
      }
      dataLoaded = true;
      refreshData = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "CHECK IN/OUT MODEL",
            style: CustomTextStyles.textStyleTitle(context),
          ),
          const SizedBox(
            height: 25,
          ),
          FutureBuilder(
            future: getModelsListData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text("NO CONNECTION");
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton2(
                      hint: Text(
                        'Select Model',
                        style: CustomTextStyles.textStyleTableColumn(context),
                      ),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CustomColors().websiteBackgroundColor,
                      ),
                      items: futureData
                          .map((item) => DropdownMenuItem<CheckModel>(
                                value: item,
                                child: Text(
                                  item.name.toString(),
                                  style: CustomTextStyles.textStyleTableColumn(
                                      context),
                                ),
                              ))
                          .toList(),
                      value: selectedDropDownValue,
                      onChanged: (value) {
                        setState(() {
                          selectedDropDownValue = value as CheckModel;
                        });
                      },
                      buttonHeight: 50,
                      buttonWidth: 300,
                      itemHeight: 40,
                    ),
                    const SizedBox(width: 30,),
                    ElevatedButton(
                      onPressed: () {
                        putYachtCheckModel(widget.yacht.id!, selectedDropDownValue!.id!, context);
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
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
