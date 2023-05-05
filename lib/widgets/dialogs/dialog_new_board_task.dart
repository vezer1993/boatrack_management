import 'package:boatrack_management/models/account.dart';
import 'package:boatrack_management/models/board_task.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/accounts_api.dart';
import 'package:flutter/material.dart';
import 'package:web_date_picker/web_date_picker.dart';
import '../../resources/colors.dart';
import '../../resources/styles/box_decorations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../resources/styles/button_styles.dart';

class DialogNewBoardTask extends StatefulWidget {
  final Accounts acc;

  const DialogNewBoardTask({Key? key, required this.acc}) : super(key: key);

  @override
  State<DialogNewBoardTask> createState() => _DialogNewBoardTaskState();
}

class _DialogNewBoardTaskState extends State<DialogNewBoardTask> {
  TextEditingController noteDescription = TextEditingController();
  DateTime? dt = DateTime.now();
  bool sendingData = false;

  var parentGroupItems = [
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];

  var parentGroup = "12";
  double priority = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double containerWidth = 400;
    double containerHeight = 600;

    if (width < 800) {
      containerWidth = width * 0.7;
      height = height * 0.8;
    }

    return Dialog(
      child: Container(
        height: containerHeight,
        width: containerWidth,
        color: CustomColors().websiteBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "NEW BOARD TASK",
                style: CustomTextStyles.textStyleTitle(context),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "TASK DESCRIPTION",
                style: CustomTextStyles.textStyleTableColumn(context),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Center(
                    child: TextField(
                      controller: noteDescription,
                      style:
                          CustomTextStyles.textStyleTableColumnNoBold(context),
                      minLines: 3,
                      maxLines: 5,
                      decoration:
                          CustomBoxDecorations.getStandardInputDecoration(
                                  context, true)
                              .copyWith(hintText: "TASK NOTE"),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "DEADLINE",
                style: CustomTextStyles.textStyleTableColumn(context),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WebDatePicker(
                  firstDate: DateTime.now(),
                  onChange: (value) {
                    dt = value;
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton2(
                  hint: Text(
                    'Select Group',
                    style: CustomTextStyles.textStyleTableColumn(context),
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: CustomColors().websiteBackgroundColor,
                  ),
                  items: parentGroupItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item.toString(),
                              style: CustomTextStyles.textStyleTableColumn(
                                  context),
                            ),
                          ))
                      .toList(),
                  value: parentGroup,
                  onChanged: (value) {
                    setState(() {
                      parentGroup = value.toString();
                    });
                  },
                  buttonHeight: 50,
                  buttonWidth: 105,
                  itemHeight: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "PRIORITY",
                style: CustomTextStyles.textStyleTableColumn(context),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 3,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const Icon(
                      Icons.star,
                      color: Colors.green,
                    );
                  case 1:
                    return const Icon(
                      Icons.star,
                      color: Colors.orange,
                    );
                  case 2:
                    return const Icon(
                      Icons.star,
                      color: Colors.red,
                    );
                  default:
                    return const Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                }
              },
              onRatingUpdate: (rating) {
                priority = rating;
              },
            ),
            const SizedBox(height: 30,),
            Center(
              child: SizedBox(
                width: 170,
                height: 35,
                child: ElevatedButton(
                  style: CustomButtonStyles.getStandardButtonStyle(),
                  onPressed: sendingData ? null : () async {
                    dt = DateTime(dt!.year, dt!.month, dt!.day, int.parse(parentGroup));

                    BoardTask bt = BoardTask();
                    bt.deadline = dt!.toIso8601String();
                    bt.accountId = widget.acc.id;
                    bt.resolved = false;
                    bt.priorityLevel = priority.toString();
                    bt.task = noteDescription.text.toString();
                    bt.charterId = 1;

                    bool success = await postNewBoardTask(bt, context);
                    Navigator.pop(context);
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "ADD TASK",
                    style: CustomTextStyles
                        .getButtonTextStyle(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
