import 'package:boatrack_management/widgets/employees/sub_widgets/employee_board_account_widget.dart';
import 'package:flutter/material.dart';

import '../../models/account.dart';
import '../../services/accounts_api.dart';

class EmployeeBoardWidget extends StatefulWidget {
  const EmployeeBoardWidget({Key? key}) : super(key: key);

  @override
  State<EmployeeBoardWidget> createState() => _EmployeeBoardWidgetState();
}

class _EmployeeBoardWidgetState extends State<EmployeeBoardWidget> {
  late List<Accounts> futureData;
  bool dataLoaded = false;

  Future getEmployeeList() async {
    if (!dataLoaded) {
      futureData = await getUserList();
      dataLoaded = true;
    }
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEmployeeList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NO CONNECTION");
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
                width: 1200,
                height: 1000,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 300/500,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                  itemCount: futureData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EmployeeBoardAccountWidget(acc: futureData[index]);
                  },
                ));
          }
        });
  }
}
