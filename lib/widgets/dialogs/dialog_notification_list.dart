import 'package:boatrack_management/models/notification_list.dart';
import 'package:boatrack_management/models/notification_type.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/widgets/dialogs/dialog_issue_explorer.dart';
import 'package:flutter/material.dart';

class DialogNotificationList extends StatefulWidget {
  final NotificationList notifications;

  const DialogNotificationList({Key? key, required this.notifications})
      : super(key: key);

  @override
  State<DialogNotificationList> createState() => _DialogNotificationListState();
}

class _DialogNotificationListState extends State<DialogNotificationList> {
  double containerWidth = 400;
  Color backgroundColor = CustomColors().altBackgroundColor;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      alignment: Alignment.topRight,
      insetPadding: EdgeInsets.only(top: 95, right: 100),
      child: Container(
        height: 500,
        width: containerWidth,
        decoration: CustomBoxDecorations.standardBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: CustomColors().borderColor,
            ),
            itemCount: widget.notifications.notifications.length,
            itemBuilder: (BuildContext context, int index) {

              IconData iconType = Icons.group;
              Widget? prompt;

              if(widget.notifications.notifications[index].type == NotificationEnum.issue){
                iconType = Icons.report_problem;
                prompt = DialogIssueExplorer(issueID: widget.notifications.notifications[index].typeId.toString());
              }

              return MouseRegion(
                onEnter: (value) {
                  setState(() {
                  });
                },
                onExit: (value) {

                },
                child: InkWell(
                  onTap: () {
                    if(prompt != null){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return prompt!;
                        },
                      );
                    }
                  },
                  child: Container(
                    width: containerWidth,
                    height: 75,
                    color: backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Icon(iconType, color: CustomColors().navigationIconColor, size: 35,),
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.notifications.notifications[index].message
                                      .toString(),
                                  style: CustomTextStyles.textStyleTableColumn(
                                      context),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    widget.notifications.notifications[index]
                                        .getTimeStamp(),
                                    style: CustomTextStyles.textStyleTableHeader(
                                        context)?.copyWith(color: CustomColors().primaryColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Visibility(
                              visible: widget.notifications.newNotifications > index,
                              child: Center(
                                child: Icon(Icons.circle, color: CustomColors().primaryColor,),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
