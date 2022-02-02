import 'package:flutter/material.dart';
import 'package:revision_planner/controller/statscontroller.dart';
import 'package:get/get.dart';

class NewSecondPage extends StatelessWidget {
  NewSecondPage({Key? key}) : super(key: key);

  final statsController = Get.put(StatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetX<StatsController>(builder: (controller) {
      return controller.statsList.isNotEmpty
          ? ListView.builder(
              itemCount: controller.statsList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text(
                      controller.statsList[index].curDate,
                      style: const TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Text(
                        'New: ' +
                            controller.statsList[index].newTopics.toString(),
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      Text(
                        'Revised: ' +
                            controller.statsList[index].completed.toString(),
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      Text(
                        'Pending: ' +
                            controller.statsList[index].pending.toString(),
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              })
          : const Center(
              child: Text('No Data'),
            );
    }));
  }
}
