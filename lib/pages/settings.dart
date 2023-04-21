import 'package:flutter/material.dart';

import '../models/yacht.dart';
import '../resources/separators.dart';
import '../services/yachts_api.dart';
import '../widgets/user_interface/header.dart';
import '../widgets/user_interface/settings_menu_header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Widget currentSettingsWidget = Center();

  /// FUTURE DATA
  late List<Yacht> futureData;
  bool dataLoaded = false;

  Future getYachtListData() async {
    if (!dataLoaded) {
      futureData = await getYachtList(false);
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getYachtListData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeaderWidget(previousPage: '',),
                    Separators.dashboardVerticalSeparator(),
                    SettingsMenuHeaderWidget(notifyParent: changeSettingsWidget, yachts: futureData,),
                    Separators.dashboardVerticalSeparator(),
                    currentSettingsWidget,
                    Separators.dashboardVerticalSeparator(),
                    //HalfSizeContainer(parentSize: mySize)
                  ],
                ),
              ),
            );
          }
        });
  }

  void changeSettingsWidget(Widget w){
    setState(() {
      currentSettingsWidget = w;
    });
  }
}
