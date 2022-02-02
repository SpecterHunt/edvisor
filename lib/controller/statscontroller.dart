import 'package:get/get.dart';
import 'package:revision_planner/models/stats.dart';
import 'package:revision_planner/utils/databse_util.dart';

class StatsController extends GetxController {
  var statsList = <Stats>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  void fetchTopics() async {
    var listOfTopics = await DatabaseHelper.instance.dsFetchAllStats();
    update();
    statsList.value = listOfTopics;
  }
}
