import 'package:boatrack_management/models/yacht.dart';
import 'package:boatrack_management/resources/strings.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:boatrack_management/widgets/dashboard/dashboard_calendar_widget.dart';
import 'package:boatrack_management/widgets/dashboard/dashboard_current_booking_widget.dart';
import 'package:boatrack_management/widgets/dashboard/dashboard_unresolved_issue_list_widget.dart';
import 'package:boatrack_management/widgets/user_interface/header.dart';
import 'package:flutter/material.dart';
import '../resources/separators.dart';
import '../widgets/containers/double_widget_container.dart';
import '../widgets/containers/full_width_container.dart';
import '../widgets/dashboard/dashboard_employee_task_list_widget.dart';
import '../widgets/dashboard/dashboard_yacht_list_widget.dart';

class DashboardPage extends StatefulWidget {
  final Function notifyParent;
  const DashboardPage({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

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
                      FullWidthContainer(
                        title: StaticStrings.getDashboardCalendarTitle(),
                        childWidget: DashboardCalendarWidget(
                          yachts: futureData,
                        ),
                      ),
                      Separators.dashboardVerticalSeparator(),
                      DoubleWidgetContainer(title1:  StaticStrings.dashboardYachtListTitle, widget1: DashboardYachtListWidget(yachts: futureData, notifyParent: notifyParent,),title2: "", widget2: Column(children: [Text("ACTIVE TASKS", style: CustomTextStyles.textStyleTitle(context),), const SizedBox(height: 10,),const EmployeeTaskListWidget(), const SizedBox(height: 20,),Text("UNRESOLVED ISSUES", style: CustomTextStyles.textStyleTitle(context),), const SizedBox(height: 10,), const DashboardUnresolvedIssueList()],),),
                      Separators.dashboardVerticalSeparator(),
                      //HalfSizeContainer(parentSize: mySize)
                    ],
                  ),
                ),
            );
          }
        });
  }

  void notifyParent(Yacht y){
    widget.notifyParent(y);
  }
}
