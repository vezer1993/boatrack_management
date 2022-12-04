import 'package:boatrack_management/models/check_in_out.dart';
import 'package:boatrack_management/models/cleaning.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../models/yacht.dart';
import '../../resources/styles/box_decorations.dart';
import '../yachts/yacht_information_widget.dart';
import 'dialog_yacht_explorer_cleaning.dart';

class DialogYachtExplorer extends StatefulWidget {
  final Yacht yacht;
  final CheckInOut? checkInOut;
  final Cleaning? cleaning;

  const DialogYachtExplorer({Key? key, required this.yacht, this.checkInOut, this.cleaning}) : super(key: key);

  @override
  State<DialogYachtExplorer> createState() => _DialogYachtExplorerState();
}

class _DialogYachtExplorerState extends State<DialogYachtExplorer> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double containerWidth = 700;
    double containerHeight = 900;

    if(width < 800){
      containerWidth = width * 0.7;
      height = height * 0.8;
    }
    
    Widget mainWidget = const SizedBox();
    
    if(widget.checkInOut != null){
      
    }
    
    if(widget.cleaning != null){
      mainWidget = DialogYachtExplorerCleaning(cleaning: widget.cleaning!, yacht: widget.yacht,);
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
                Padding(padding: const EdgeInsets.only(left: 20), child: Text(widget.yacht.name.toString(), style: CustomTextStyles.textStyleCharterName(context),),),
                const SizedBox(height: 20,),
                mainWidget,
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CustomColors().altBackgroundColor,
                      boxShadow: [CustomBoxDecorations.containerBoxShadow()]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.yacht.name.toString() + " INFORMATION",
                        style: CustomTextStyles.textStyleTitle(context),
                      ),
                      const SizedBox(height: 15,),
                      YachtInformationWidget(yacht: widget.yacht, containerHeight: 400)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
