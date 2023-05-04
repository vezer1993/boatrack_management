import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/widgets/settings/settings_check_model.dart';
import 'package:boatrack_management/widgets/settings/settings_teltonika.dart';
import 'package:flutter/material.dart';

import '../../models/yacht.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/values.dart';
import '../settings/settings_accounts.dart';
import '../settings/settings_visibility.dart';

class SettingsMenuHeaderWidget extends StatefulWidget {

  final Function notifyParent;
  final List<Yacht> yachts;
  const SettingsMenuHeaderWidget({Key? key, required this.notifyParent, required this.yachts}) : super(key: key);

  @override
  State<SettingsMenuHeaderWidget> createState() => _SettingsMenuHeaderWidgetState();
}

class _SettingsMenuHeaderWidgetState extends State<SettingsMenuHeaderWidget> {

  List<Color> menuItemBackgrounds = [];
  int selectedItem = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // add background for each item
    if(menuItemBackgrounds.isEmpty){
      menuItemBackgrounds.add(Colors.transparent);
      menuItemBackgrounds.add(Colors.transparent);
      menuItemBackgrounds.add(Colors.transparent);
      menuItemBackgrounds.add(Colors.transparent);
    }

    return Container(
      width: double.infinity,
      decoration: CustomBoxDecorations.standardBoxDecoration(),
      child: Padding(
          padding: EdgeInsets.all(StaticValues.standardContainerPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    menuItemBackgrounds[selectedItem] = Colors.transparent;
                    selectedItem = 0;
                    menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  });
                  widget.notifyParent(SettingsTeltonikaWidget(yachts: widget.yachts));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[0],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("TELTONIKA", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  menuItemBackgrounds[selectedItem] = Colors.transparent;
                  selectedItem = 1;
                  menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  widget.notifyParent(const SettingsAccountsWidget());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[1],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("ACCOUNTS", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  menuItemBackgrounds[selectedItem] = Colors.transparent;
                  selectedItem = 2;
                  menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  widget.notifyParent(const SettingsCheckModelWidget());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[2],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("CHECK IN/OUT MODEL", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  menuItemBackgrounds[selectedItem] = Colors.transparent;
                  selectedItem = 3;
                  menuItemBackgrounds[selectedItem] = CustomColors().selectedItemColor;
                  widget.notifyParent(const SettingsYachtVisibilityWidget());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: menuItemBackgrounds[3],
                  ),
                  child: Padding(
                    padding: StaticValues.standardTableItemPadding(),
                    child: Text("YACHT VISIBILITY", style: CustomTextStyles.getUIMenuTextStyle(context),),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
