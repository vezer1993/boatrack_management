import 'package:boatrack_management/resources/colors.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/box_decorations.dart';
import '../../resources/values.dart';

class HeaderWidget extends StatefulWidget {
  final String previousPage;
  final Function? goPageBack;
  const HeaderWidget({Key? key, required this.previousPage, this.goPageBack}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool prevPageVisible = false;
  @override
  Widget build(BuildContext context) {
    if(widget.previousPage != ""){
      prevPageVisible = true;
    }
    return Container(
      width: double.infinity,
      decoration: CustomBoxDecorations.standardBoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(StaticValues.standardContainerPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: prevPageVisible,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Back',
                color: CustomColors().navigationIconColor,
                iconSize: 24,
                onPressed: () {
                  setState(() {
                    widget.goPageBack!(widget.previousPage);
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.add_alert),
                  tooltip: 'Alerts',
                  color: CustomColors().navigationIconColor,
                  iconSize: 24,
                  onPressed: () {
                    setState(() {
                      widget.goPageBack!(widget.previousPage);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.sync),
                  tooltip: 'Sync Data',
                  color: CustomColors().navigationIconColor,
                  iconSize: 24,
                  onPressed: () {
                    setState(() {
                      //TODO: REFRESH DATA
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
