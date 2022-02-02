import 'package:get/get.dart';
import 'package:revision_planner/models/topics.dart';
import 'package:revision_planner/utils/databse_util.dart';

class AllTopicsController extends GetxController {
  var allTopics = <Topics>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  void fetchTopics() async {
    var listOfTopics = await DatabaseHelper.instance.fetchAllTopics();
    update();
    allTopics.value = listOfTopics;
  }
}
