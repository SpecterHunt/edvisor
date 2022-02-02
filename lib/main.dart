import 'package:flutter/material.dart';
import 'package:revision_planner/view/pages/new_addnewtopicspage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:revision_planner/view/pages/new_loginpage.dart';
import 'package:revision_planner/view/pages/new_homepage.dart';
import 'package:revision_planner/view/pages/new_taskdescriptionpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: isLoggedIn == null ? '/login' : '/newHome',
    getPages: [
      GetPage(name: '/addNewTopic', page: () => const AddNewTopics()),
      GetPage(name: '/login', page: () => const LoginPage()),
      GetPage(name: '/newHome', page: () => const NewHomePage()),
      GetPage(name: '/descriptor', page: () => const TaskDescriptor()),
    ],
  ));
}
