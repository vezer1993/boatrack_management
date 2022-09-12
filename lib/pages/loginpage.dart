import 'package:boatrack_management/resources/separators.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/colors.dart';
import '../resources/styles/button_styles.dart';
import '../resources/styles/text_styles.dart';
import '../services/accounts_api.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double elementWidth = 350;
    double elementHeight = 38;

    return Scaffold(
        backgroundColor: CustomColors().websiteBackgroundColor,
        body: SizedBox(
          width: s.width,
          height: s.height,
          child: Center(
            child: Container(
              height: s.height/3,
              decoration: CustomBoxDecorations.standardBoxDecoration(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome to BoaTrack!", style: CustomTextStyles.textStyleTitle(context),),
                    Separators.dashboardVerticalSeparator(),
                    SizedBox(
                      width: elementWidth,
                      height: elementHeight,
                      child: TextField(
                        controller: usernameTextController,
                        style:
                            CustomTextStyles.textStyleTableColumnNoBold(context),
                        maxLines: 1,
                        cursorColor: CustomColors().primaryColor,
                        decoration:
                            CustomBoxDecorations.getLoginInputDecoration(
                                context, true).copyWith(labelText: "USERNAME", labelStyle: CustomTextStyles.textStyleTableDescription(context)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: elementWidth,
                      height: elementHeight,
                      child: TextField(
                        controller: passwordTextController,
                        style:
                            CustomTextStyles.textStyleTableColumnNoBold(context),
                        maxLines: 1,
                        cursorColor: CustomColors().primaryColor,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration:
                            CustomBoxDecorations.getLoginInputDecoration(
                                context, true).copyWith(labelText: "PASSWORD", labelStyle: CustomTextStyles.textStyleTableDescription(context)),
                      ),
                    ),
                    Separators.dashboardVerticalSeparator(),
                    SizedBox(
                        width: elementWidth,
                        height: elementHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: CustomButtonStyles.getStandardButtonStyle(),
                          child: Text(
                            "LOGIN",
                            style: CustomTextStyles.getButtonTextStyle(context),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future login () async {
    bool loggedIn = await loginToWeb(usernameTextController.text, passwordTextController.text);

    if(loggedIn){
      Get.offNamed('/dashboard');
    }
  }
}
