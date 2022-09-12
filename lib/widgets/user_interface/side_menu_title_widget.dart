import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SideMenuTitleWidget extends StatefulWidget {
  const SideMenuTitleWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuTitleWidget> createState() => _SideMenuTitleWidgetState();
}

class _SideMenuTitleWidgetState extends State<SideMenuTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 200.0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                //TODO: GET CHARTER NAME
                "CROSAIL",
                style: CustomTextStyles.textStyleCharterName(context),
              ),
              const SizedBox(height: 5),
              Text(
                "Admin",
                style: CustomTextStyles.textStyleTitle(context),
              )
            ],
          );
        } else {
          return Center(
            child: Text("C", style: CustomTextStyles.textStyleCharterName(context),),
          );
        }
      }),
    );
  }
}
