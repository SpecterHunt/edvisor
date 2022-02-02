import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revision_planner/controller/pendingtopicscontroller.dart';
import 'package:revision_planner/utils/databse_util.dart';

class NewPendingTopicsPage extends StatelessWidget {
  NewPendingTopicsPage({Key? key}) : super(key: key);
  final PendingTopicsController pendingTopicsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<PendingTopicsController>(
        builder: (controller) {
          return controller.pendingTopics.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.pendingTopics.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          gradient: controller
                                      .pendingTopics[index].difficulty ==
                                  'Hard'
                              ? LinearGradient(colors: [
                                  const Color(0xff1B4EE5).withOpacity(0.7),
                                  const Color(0xff3962DB).withOpacity(0.7)
                                ])
                              : controller.pendingTopics[index].difficulty ==
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
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.pendingTopics[index].title,
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
                                            controller
                                                .pendingTopics[index].curDate
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontFamily: 'Poppins'),
                                          ),
                                          // const Icon(
                                          //   Icons.circle,
                                          //   size: 7,
                                          //   color: Color(0xff9EF559),
                                          // ),
                                          // const SizedBox(
                                          //   width: 4,
                                          // ),
                                          // Text(
                                          //   controller
                                          //       .revTopics[index].difficulty
                                          //       .toString(),
                                          //   style: const TextStyle(
                                          //     fontSize: 11,
                                          //     color: Colors.white,
                                          //     fontFamily: 'Poppins',
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
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
                                    .onDone2(controller.pendingTopics[index].id)
                                    .whenComplete(() {
                                  controller.pendingTopics.removeAt(index);
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
                                      // controller.revTopics[index].curDate.toString(),
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
