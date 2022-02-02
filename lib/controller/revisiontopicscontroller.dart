import 'package:get/get.dart';
import 'package:revision_planner/models/topics.dart';
import 'package:revision_planner/utils/databse_util.dart';

class RevisionTopicsController extends GetxController {
  var revTopics = <Topics>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  void fetchTopics() async {
    var listOfTopics = await DatabaseHelper.instance.fetchRevisionTopics();
    if (listOfTopics.isNotEmpty) {
      await DatabaseHelper.instance.dsPending(listOfTopics.length);
    }
    update();
    revTopics.value = listOfTopics;
  }

  // void onDone(String id) async {
  //   await DatabaseHelper.instance.onDone(id);
  //   update();
  // }
}
