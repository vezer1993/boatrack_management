import 'package:boatrack_management/helpers/session.dart';
import 'package:boatrack_management/pages/loginpage.dart';
import 'package:boatrack_management/pages/mainpage.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'BoaTrack Dashboard',
    theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Lato",
        backgroundColor: CustomColors().websiteBackgroundColor,
        brightness: Brightness.dark),
    scrollBehavior: MyCustomScrollBehavior(),
    initialRoute: "/dashboard",
    getPages: [
      GetPage(
        name: '/dashboard',
        page: () => const MainPage(title: "BoaTrackDashboard"),
        middlewares: [GlobalMiddleware()],
      ),
      GetPage(
          name: '/login',
          page: () => const Loginpage(),
          middlewares: [LoginPageMiddleware()]),
    ],
  ));
}

class GlobalMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return SessionStorage.getValue(StaticStrings.getCharterSession()) == null
        ? const RouteSettings(name: "/login")
        : null;
  }
}

class LoginPageMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return SessionStorage.getValue(StaticStrings.getCharterSession()) != null
        ? const RouteSettings(name: "/dashboard")
        : null;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
