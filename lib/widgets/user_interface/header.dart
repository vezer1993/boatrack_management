import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/notifications_api.dart';
import 'package:boatrack_management/services/yachts_api.dart';
import 'package:boatrack_management/widgets/dialogs/dialog_notification_list.dart';
import 'package:flutter/material.dart';

import '../../models/notification_list.dart';
import '../../resources/styles/box_decorations.dart';
import '../../resources/values.dart';

class HeaderWidget extends StatefulWidget {
  final String previousPage;
  final Function? goPageBack;

  const HeaderWidget({Key? key, required this.previousPage, this.goPageBack})
      : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool prevPageVisible = false;

  late NotificationList futureData;

  Future getFutureData() async {
    futureData = await getNotificationList();
    return futureData;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.previousPage != "") {
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
                FutureBuilder(
                    future: getFutureData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const Text("NO CONNECTION");
                      } else if (!snapshot.hasData) {
                        return IconButton(
                            icon: const Icon(Icons.add_alert),
                            tooltip: 'Alerts',
                            color: CustomColors().navigationIconColor,
                            iconSize: 24,
                            onPressed: () {});
                      } else {
                        return Stack(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.add_alert),
                                tooltip: 'Alerts',
                                color: CustomColors().navigationIconColor,
                                iconSize: 24,
                                onPressed: () async {
                                  updateNotificationListSession();
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return DialogNotificationList(
                                          notifications: futureData,
                                        );
                                      });
                                }),
                            Visibility(
                              visible: futureData.newNotifications > 0,
                              child: Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: CustomColors().failBoxCheckMarkColor,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0.5,0,0,1),
                                      child: Text(
                                        futureData.newNotifications.toString(), style: CustomTextStyles.textStyleTableColumn(context)?.copyWith(fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                IconButton(
                  icon: const Icon(Icons.sync),
                  tooltip: 'Sync Data',
                  color: CustomColors().navigationIconColor,
                  iconSize: 24,
                  onPressed: () async {
                    setState(() {
                      updateYachtList();
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
