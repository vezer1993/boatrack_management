import 'package:boatrack_management/pages/bookings.dart';
import 'package:boatrack_management/pages/dashboard.dart';
import 'package:boatrack_management/pages/employee.dart';
import 'package:boatrack_management/pages/settings.dart';
import 'package:boatrack_management/pages/yacht.dart';
import 'package:boatrack_management/pages/yachts.dart';
import 'package:boatrack_management/resources/styles/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import '../models/yacht.dart';
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
  final PageController _pageController = PageController();

  Yacht selectedYacht = Yacht();
  int selectedEmployeeID = 0;

  @override
  Widget build(BuildContext context) {
    initSideMenuItems();

    return Scaffold(
      backgroundColor: CustomColors().websiteBackgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///SIDE MENU (LEFT SIDE)
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
            // List of SideMenuItem to show them on SideMenu
            items: sideMenuItems,
          ),

          ///RIGHT SIDE PAGES
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 35, 15, 0),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  DashboardPage(notifyParent: openYachtPage,),
                  YachtsPage(notifyParent: openYachtPage, yacht: selectedYacht, notifyParentGoPageBack: pageBack,),
                  const BookingsPage(),
                  EmployeePage(selectedEmployee: selectedEmployeeID,),
                  const SettingsPage()
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
        title: 'Boats',
        onTap: () => _pageController.jumpToPage(1),
        icon: const Icon(Icons.directions_boat_outlined),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Bookings',
        onTap: () => _pageController.jumpToPage(2),
        icon: const Icon(Icons.calendar_today_outlined),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Employees',
        onTap: () => _pageController.jumpToPage(3),
        icon: const Icon(Icons.supervised_user_circle),
      ),
      SideMenuItem(
        priority: 4,
        title: 'Settings',
        onTap: () => _pageController.jumpToPage(4),
        icon: const Icon(Icons.settings),
      ),
      SideMenuItem(
        priority: 5,
        title: 'Log Out',
        onTap: () {},
        icon: const Icon(Icons.exit_to_app),
      ),
    ];
  }

  void openYachtPage(Yacht y){
    setState(() {
      selectedYacht = y;
      _pageController.jumpToPage(1);
    });
  }
  
  void pageBack(String page){
    if(page == "yachts"){
      setState(() {
        selectedYacht = Yacht();
        _pageController.jumpToPage(1);
      });
    }
  }
}
