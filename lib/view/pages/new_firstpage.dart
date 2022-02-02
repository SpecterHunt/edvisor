import 'package:flutter/material.dart';
import 'package:revision_planner/controller/pendingtopicscontroller.dart';
import 'package:revision_planner/controller/revisiontopicscontroller.dart';
import 'package:revision_planner/view/pages/new_newtopicspage.dart';
import 'package:revision_planner/view/pages/new_pendigtopicspage.dart';
import 'package:revision_planner/view/pages/new_revisiontopicspage.dart';
import 'package:get/get.dart';

class NewFirstPage extends StatefulWidget {
  const NewFirstPage({Key? key}) : super(key: key);

  @override
  State<NewFirstPage> createState() => _NewFirstPageState();
}

class _NewFirstPageState extends State<NewFirstPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ctrl = Get.put(RevisionTopicsController());
  final control = Get.put(PendingTopicsController());

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double hPadding = width * 0.05;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.014,
          ),
          Padding(
            padding: EdgeInsets.only(left: hPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Image(
                    image: const AssetImage('assets/images/Logo2-4.png'),
                    height: height * 0.05,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            child: Center(
              child: Container(
                height: height * 0.16,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Group 3.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 18.0, right: 18, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Hard work is the key to success',
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_alarm,
                            color: Colors.white,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GetBuilder<RevisionTopicsController>(
                            builder: (_) => Text(
                              '${ctrl.revTopics.length.toString()} tasks left',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: hPadding + 5.0, right: hPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Tasks',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: const BorderSide(width: 2, color: Color(0xff0E46EB)),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        color: Color(0xff0E46EB),
                      ),
                      Text(
                        ' New Topic',
                        style: TextStyle(
                            color: Color(0xff0E46EB), fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Get.toNamed('/addNewTopic');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: hPadding - 10.0),
            child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
                labelColor: const Color(0xff0E46EB),
                labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
                controller: _tabController,
                tabs: [
                  const Tab(
                    text: 'To Revise',
                  ),
                  const Tab(
                    text: 'New Topics',
                  ),
                  GetBuilder<PendingTopicsController>(
                      builder: (_) => Tab(
                            text:
                                'Pending(${control.pendingTopics.length.toString()})',
                          )),
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: hPadding, right: hPadding),
                  child: NewRevisionTopicsPage(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: hPadding, right: hPadding),
                  child: NewTopicsPage2(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: hPadding, right: hPadding),
                  child: NewPendingTopicsPage(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
