import 'package:boatrack_management/pages/mainpage.dart';
import 'package:boatrack_management/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root of application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoaTrack Dashboard',
      theme: _buildTheme(Brightness.dark),
      scrollBehavior: MyCustomScrollBehavior(),
      home: const MainPage(title: 'BoaTrack Dashboard'),
    );
  }

  //Theme setup
  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      backgroundColor: CustomColors().websiteBackgroundColor,
    );
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
