import 'package:boatrack_management/pages/yacht.dart';
import 'package:boatrack_management/widgets/dashboard/dashboard_yacht_list_widget.dart';
import 'package:flutter/material.dart';

import '../models/yacht.dart';
import '../resources/separators.dart';
import '../services/yachts_api.dart';
import '../widgets/containers/double_widget_container.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/user_interface/header.dart';
import '../widgets/yachts/yachts_map.dart';

class YachtsPage extends StatefulWidget {
  final Function notifyParent;
  final Function notifyParentGoPageBack;
  final Yacht yacht;
  const YachtsPage({Key? key, required this.notifyParent, required this.yacht, required this.notifyParentGoPageBack}) : super(key: key);

  @override
  State<YachtsPage> createState() => _YachtsPageState();
}

class _YachtsPageState extends State<YachtsPage> {
  /// FUTURE DATA
  late List<Yacht> futureData;
  bool dataLoaded = false;

  Future getYachtListData() async {
    if (!dataLoaded) {
      futureData = await getYachtList();
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {

    if(widget.yacht.id == null) {
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
                      HeaderWidget(previousPage: '',),
                      Separators.dashboardVerticalSeparator(),
                      FullWidthContainer(
                        title: "Yacht Locations",
                        childWidget: YachtsMapWidget(
                          yachts: futureData,
                        ),
                      ),
                      Separators.dashboardVerticalSeparator(),
                      FullWidthContainer(
                          title: "Boats",
                          childWidget: Center(
                            child: DashboardYachtListWidget(
                              yachts: futureData, notifyParent: notifyParent,
                            ),
                          )),
                      Separators.dashboardVerticalSeparator(),
                    ],
                  ),
                ),
              );
            }
          });
    }else{
      return YachtPage(yacht: widget.yacht, notifyParentGoPageBack: notifyParentGoPageBack,);
    }
  }
  void notifyParent(Yacht y){
    widget.notifyParent(y);
  }

  void notifyParentGoPageBack(String page){
    widget.notifyParentGoPageBack(page);
  }
}
