import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revision_planner/controller/revisiontopicscontroller.dart';
import 'package:revision_planner/utils/databse_util.dart';

class NewRevisionTopicsPage extends StatelessWidget {
  NewRevisionTopicsPage({Key? key}) : super(key: key);
  final RevisionTopicsController revisionTopicsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<RevisionTopicsController>(
        builder: (controller) {
          return controller.revTopics.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.revTopics.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          gradient: controller.revTopics[index].difficulty ==
                                  'Hard'
                              ? LinearGradient(colors: [
                                  const Color(0xff1B4EE5).withOpacity(0.7),
                                  const Color(0xff3962DB).withOpacity(0.7)
                                ])
                              : controller.revTopics[index].difficulty ==
                                      'Medium'
                                  ? LinearGradient(colors: [
                                      const Color(0xffFF44A9).withOpacity(0.8),
                                      const Color(0xffD872F1).withOpacity(0.8),
                                    ])
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xff96D962),
                                        Color(0xff9EF559)
                                      ],
                                    )),
                      margin: const EdgeInsets.only(
                          left: 0, right: 0, top: 4, bottom: 4),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('/descriptor', arguments: {
                                      'title':
                                          controller.revTopics[index].title,
                                      'difficulty': controller
                                          .revTopics[index].difficulty,
                                      'curDate':
                                          controller.revTopics[index].curDate,
                                      'info': controller.revTopics[index].info,
                                    });
                                  },
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.revTopics[index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Last revised : ',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins'),
                                            ),
                                            Text(
                                              controller.revTopics[index]
                                                          .lastRevised
                                                          .toString() ==
                                                      'null'
                                                  ? 'Not yet revised'
                                                  : controller.revTopics[index]
                                                      .lastRevised
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.white,
                            ),
                            InkWell(
                              onTap: () {
                                DatabaseHelper.instance
                                    .onDone2(controller.revTopics[index].id)
                                    .whenComplete(() {
                                  DatabaseHelper.instance.dsRevised(
                                      controller.revTopics.length - 1);
                                  controller.revTopics.removeAt(index);
                                  controller.update();
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(8, 20, 16, 20),
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    'No Items to display',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
        },
      ),
    );
  }
}
