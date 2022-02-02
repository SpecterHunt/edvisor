import 'package:flutter/material.dart';
import 'package:revision_planner/controller/navigationcontroller.dart';
import 'package:revision_planner/utils/databse_util.dart';
import 'package:get/get.dart';
import 'package:revision_planner/view/pages/new_firstpage.dart';
import 'package:revision_planner/view/pages/new_moresettingpage.dart';
import 'package:revision_planner/view/pages/new_secondpage.dart';
import 'package:revision_planner/view/pages/new_thirdpage.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final navController = Get.put(NavController());

  final List<Widget> pages = [
    const NewFirstPage(),
    NewSecondPage(),
    const ThirdPage(),
    const MoreSettingsPage()
  ];

  final List<Icon> icons = [
    const Icon(Icons.home_outlined),
    const Icon(Icons.insights_outlined),
    const Icon(Icons.account_circle_outlined),
    const Icon(Icons.more_horiz),
  ];

  _bottomNavitionBarItem({required Icon icon, required String label}) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }

  @override
  void initState() {
    DatabaseHelper.instance.setPending();
    DatabaseHelper.instance.dsNewEntry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(builder: (controller) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: SafeArea(
            child: IndexedStack(
              index: controller.selectedIndex,
              children: pages,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            selectedItemColor: const Color(0xff0E46EB),
            unselectedItemColor: const Color(0xFF3D3D3D),
            currentIndex: controller.selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: controller.changeIndex,
            items: [
              _bottomNavitionBarItem(icon: icons[0], label: '.'),
              _bottomNavitionBarItem(icon: icons[1], label: '.'),
              _bottomNavitionBarItem(icon: icons[2], label: '.'),
              _bottomNavitionBarItem(icon: icons[3], label: '.'),
            ],
          ));
    });
  }
}
