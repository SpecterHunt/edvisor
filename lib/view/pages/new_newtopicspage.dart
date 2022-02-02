import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:revision_planner/controller/newtopicscontroller.dart';
import 'package:revision_planner/utils/databse_util.dart';

class NewTopicsPage2 extends StatelessWidget {
  NewTopicsPage2({Key? key}) : super(key: key);

  final newTopicsController = Get.put(NewTopicsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetX<NewTopicsController>(builder: (controller) {
      return controller.topics.isNotEmpty
          ? ListView.builder(
              itemCount: controller.topics.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: controller.topics[index].difficulty == 'Hard'
                          ? LinearGradient(colors: [
                              const Color(0xff1B4EE5).withOpacity(0.7),
                              const Color(0xff3962DB).withOpacity(0.7)
                            ])
                          : controller.topics[index].difficulty == 'Medium'
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
                                  'title': controller.topics[index].title,
                                  'difficulty':
                                      controller.topics[index].difficulty,
                                  'curDate': controller.topics[index].curDate,
                                  'info': controller.topics[index].info,
                                });
                              },
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.topics[index].title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      controller.topics[index].difficulty
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              DatabaseHelper.instance
                                  .deleteTopic(controller.topics[index].id)
                                  .whenComplete(() {
                                DatabaseHelper.instance.dsNewTopicDelete();
                                controller.topics.removeAt(index);
                                Fluttertoast.showToast(
                                  msg: '1 item deleted',
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              });
                            },
                            child: const SizedBox(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 20, 16, 20),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )),
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
    }));
  }
}
