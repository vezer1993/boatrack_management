import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:boatrack_management/resources/separators.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/colors.dart';
import '../resources/styles/button_styles.dart';
import '../resources/styles/text_styles.dart';
import '../services/accounts_api.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool authenticating = false;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController errorMessageController = TextEditingController();

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
                          onPressed: authenticating ? null : () {
                            setState(() {
                              authenticating = true;
                            });
                            login();
                          },
                          style: CustomButtonStyles.getStandardButtonStyle(),
                          child: Text(
                            "LOGIN",
                            style: CustomTextStyles.getButtonTextStyle(context),
                          ),
                        )),
                    Separators.dashboardVerticalSeparator(),
                    Visibility(visible: errorMessageController.text != "", child: Text(errorMessageController.text.toString(), style: CustomTextStyles.textStyleTableColumn(context)?.copyWith(color: CustomColors().failBoxCheckMarkColor),),),
                    Visibility(visible: authenticating, child: SizedBox(
                      width: 200,
                      child: SpinKitWave(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: CustomColors().primaryColor,
                            ),
                          );
                        },),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future login () async {
    var response = await loginToWeb(usernameTextController.text, passwordTextController.text) as http.Response;
    
    print(response.body);
    if(response.statusCode.toString().startsWith("2") ){
      Get.offNamed('/dashboard');
    }else{
      setState(() {
        if(response.body == "username"){
          errorMessageController.text = "User with username ${usernameTextController.text} doesn't exist";
        }else if(response.body == "password"){
          errorMessageController.text = "Password is not correct";
        }
          else{
          errorMessageController.text = response.body;
          print(response.statusCode.toString());
        }

        authenticating = false;
      });
    }
  }
}
