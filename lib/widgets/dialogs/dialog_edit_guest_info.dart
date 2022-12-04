import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:boatrack_management/services/booking_api.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../../helpers/conversions.dart';
import '../../models/booking.dart';
import '../../models/guest.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import '../../resources/styles/button_styles.dart';

class DialogEditGuestInfo extends StatefulWidget {
  final Booking booking;

  const DialogEditGuestInfo({Key? key, required this.booking})
      : super(key: key);

  @override
  State<DialogEditGuestInfo> createState() => _DialogEditGuestInfoState();
}

class _DialogEditGuestInfoState extends State<DialogEditGuestInfo> {

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController contactEditingController = TextEditingController();
  TextEditingController crewCountEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();

  ExpandableController exp1 = ExpandableController();
  ExpandableController exp2 = ExpandableController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double containerWidth = 500;
    double containerHeight = 400;

    if (width < 600) {
      containerWidth = width * 0.7;
      height = height * 0.8;
    }

    String bFrom = Conversion.convertUtcTimeToStandardFormat(
        widget.booking.datefrom.toString());
    String bTo = Conversion.convertUtcTimeToStandardFormat(
        widget.booking.dateto.toString());

    exp1.addListener(() { if(exp2.expanded && exp1.expanded){ exp2.toggle(); }});
    exp2.addListener(() { if(exp1.expanded && exp2.expanded){ exp1.toggle(); }});

    if(widget.booking.note != null){
      noteEditingController.text = widget.booking.note.toString();
    }

    return Dialog(
        child: Container(
            width: containerWidth,
            height: containerHeight,
            color: CustomColors().websiteBackgroundColor,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.booking.yacht!.name.toString(),
                        style: CustomTextStyles.textStyleTitle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        bFrom + " --> " + bTo,
                        style: CustomTextStyles.textStyleTableHeader(context),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ExpandableTheme(
                        data: ExpandableThemeData(
                            iconColor: CustomColors().primaryColor,
                            hasIcon: false,
                            alignment: Alignment.center,
                            animationDuration: const Duration(milliseconds: 500)
                        ), child: ExpandablePanel(
                        header: Container(
                          decoration: CustomBoxDecorations.standardBoxDecoration(),
                          width: double.infinity,
                          height: 30,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text("GUEST INFORMATION",style: CustomTextStyles.textStyleTableHeader(context),)),
                                  const Spacer(),
                                  Icon(Icons.arrow_downward, size: 20, color: CustomColors().primaryColor,)
                                ],
                              ),
                            )
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: double.infinity,
                            decoration: CustomBoxDecorations.standardBoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 175,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Center(
                                            child: TextField(
                                              controller: nameEditingController,
                                              style: CustomTextStyles
                                                  .textStyleTableColumnNoBold(context),
                                              maxLines: 1,
                                              decoration: CustomBoxDecorations
                                                  .getStandardInputDecoration(
                                                  context, true)
                                                  .copyWith(hintText: "GUEST NAME"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Center(
                                            child: TextField(
                                              controller: crewCountEditingController,
                                              style: CustomTextStyles
                                                  .textStyleTableColumnNoBold(context),
                                              maxLines: 1,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              decoration: CustomBoxDecorations
                                                  .getStandardInputDecoration(
                                                  context, true)
                                                  .copyWith(hintText: "CREW COUNT"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    width: 175,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Center(
                                        child: TextField(
                                          controller: contactEditingController,
                                          style: CustomTextStyles
                                              .textStyleTableColumnNoBold(context),
                                          maxLines: 1,
                                          decoration: CustomBoxDecorations
                                              .getStandardInputDecoration(
                                              context, true)
                                              .copyWith(hintText: "CONTACT"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    width: 125,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Guest topG = Guest();
                                        topG.name = nameEditingController.text;
                                        topG.email = contactEditingController.text;
                                        postGuestInformation(widget.booking.id.toString(), crewCountEditingController.text, topG, this.context);
                                        exp1.toggle();
                                      },
                                      style: CustomButtonStyles
                                          .getStandardButtonStyle(),
                                      child: Text(
                                        StaticStrings.buttonTextSave,
                                        style: CustomTextStyles
                                            .getButtonTextStyle(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        controller: exp1,
                      ),
                      ),
                      const SizedBox(height: 15,),
                      ExpandableTheme(
                        data: ExpandableThemeData(
                            iconColor: CustomColors().primaryColor,
                            hasIcon: false,
                            alignment: Alignment.center,
                            animationDuration: const Duration(milliseconds: 500)
                        ), child: ExpandablePanel(
                        header: Container(
                          decoration: CustomBoxDecorations.standardBoxDecoration(),
                          width: double.infinity,
                          height: 30,
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(child: Text("NOTE INFORMATION",style: CustomTextStyles.textStyleTableHeader(context),)),
                                    const Spacer(),
                                    Icon(Icons.arrow_downward, size: 20, color: CustomColors().primaryColor,)
                                  ],
                                ),
                              )
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: double.infinity,
                            decoration: CustomBoxDecorations.standardBoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Center(
                                        child: TextField(
                                          controller: noteEditingController,
                                          style: CustomTextStyles
                                              .textStyleTableColumnNoBold(context),
                                          maxLines: 6,
                                          minLines: 3,
                                          decoration: CustomBoxDecorations
                                              .getStandardInputDecoration(
                                              context, true)
                                              .copyWith(hintText: "NOTE"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    width: 125,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        exp2.toggle();
                                        bool success = await putBookingNote(widget.booking.id.toString(), noteEditingController.text, context);
                                        if(success){
                                          setState(() {
                                            widget.booking.note = noteEditingController.text;
                                          });
                                        }
                                      },
                                      style: CustomButtonStyles
                                          .getStandardButtonStyle(),
                                      child: Text(
                                        StaticStrings.buttonTextSave,
                                        style: CustomTextStyles
                                            .getButtonTextStyle(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        controller: exp2,
                      ),
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ))));
  }
}
