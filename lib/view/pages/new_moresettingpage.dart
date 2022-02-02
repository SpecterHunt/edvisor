import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revision_planner/view/widgets/settings_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreSettingsPage extends StatelessWidget {
  const MoreSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double hPadding = width * 0.04;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.13,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Group 3.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: hPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                  ),
                  Text(
                    'More',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 24),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.13,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hPadding),
              child: Row(
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.09,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/plant_1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Ayush Tripathi',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Software Engineer',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      Get.offAllNamed('/login');
                      // Get.toNamed('/login');
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1.5,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding + 8),
            child: Column(
              children: const [
                SettingsCard(
                    icon: Icons.account_circle_outlined,
                    title: 'Personal Data'),
                SettingsCard(icon: Icons.settings, title: 'Settings'),
                SettingsCard(icon: Icons.more_outlined, title: 'FAQs'),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
