// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDescriptor extends StatelessWidget {
  const TaskDescriptor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double hPadding = width * 0.04;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height * 0.25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Group 3.png'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: hPadding,
                    right: hPadding,
                    top: height * 0.03,
                    bottom: 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: AutoSizeText(
                        Get.arguments['title'],
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 23,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Color(0xff9EF559),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    Get.arguments['difficulty'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Added',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  Get.arguments['curDate'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 5.0, right: 5),
                    //   child: AutoSizeText(
                    //     Get.arguments['info'],
                    //     style: const TextStyle(
                    //         fontFamily: 'Poppins', fontSize: 16),
                    //     maxLines: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.53,
              width: width,
              child: Padding(
                padding:
                    EdgeInsets.only(left: hPadding + 5.0, right: hPadding + 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    Get.arguments['info'],
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
