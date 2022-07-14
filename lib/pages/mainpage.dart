import 'package:boatrack_management/pages/dashboard.dart';
import 'package:boatrack_management/resources/box_decorations.dart';
import 'package:boatrack_management/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import '../resources/colors.dart';
import '../widgets/user_interface/side_menu_title_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<SideMenuItem> sideMenuItems;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    initSideMenuItems();

    return Scaffold(
      backgroundColor: CustomColors().websiteBackgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //SIDE MENU (LEFT SIDE)
          SideMenu(
            controller: _pageController,
            title: const SideMenuTitleWidget(),
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              decoration: BoxDecoration(
                boxShadow: [
                  CustomBoxDecorations.containerBoxShadow(),
                  ]
              ),
              openSideMenuWidth: 300,
              compactSideMenuWidth: 50,
              hoverColor: CustomColors().navigationItemHoverColor,
              selectedColor: CustomColors().selectedItemColor,
              selectedIconColor: CustomColors().navigationIconColor,
              unselectedIconColor: CustomColors().navigationIconColor,
              backgroundColor: CustomColors().altBackgroundColor,
              selectedTitleTextStyle: TextStyle(color: CustomColors().navigationTextColor),
              unselectedTitleTextStyle: TextStyle(color: CustomColors().navigationTextColor),
              iconSize: 20,
            ),
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            // List of SideMenuItem to show them on SideMenu
            items: sideMenuItems,
          ),

          //RIGHT SIDE
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 125, 15, 0),
              child: PageView(
                controller: _pageController,
                children: [
                  const DashboardPage(),
                  Container(
                    child: const Center(
                      child: Text('Settings'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initSideMenuItems() {
    sideMenuItems = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Dashboard',
        onTap: () => _pageController.jumpToPage(0),
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Settings',
        onTap: () => _pageController.jumpToPage(1),
        icon: const Icon(Icons.settings),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Exit',
        onTap: () {},
        icon: const Icon(Icons.exit_to_app),
      ),
    ];
  }
}
