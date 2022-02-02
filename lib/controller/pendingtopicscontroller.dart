import 'package:get/get.dart';
import 'package:revision_planner/models/topics.dart';
import 'package:revision_planner/utils/databse_util.dart';

class PendingTopicsController extends GetxController {
  var pendingTopics = <Topics>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  void fetchTopics() async {
    var listOfTopics = await DatabaseHelper.instance.fetchPendingTopics();
    update();
    pendingTopics.value = listOfTopics;
  }
}
