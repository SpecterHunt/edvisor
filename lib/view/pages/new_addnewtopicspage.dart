// ignore_for_file: must_be_immutable, avoid_print, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:revision_planner/controller/newtopicscontroller.dart';
import 'package:revision_planner/models/topics.dart';
import 'package:revision_planner/utils/databse_util.dart';
import 'package:revision_planner/utils/revisiondate_util.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:get/get.dart';

class AddNewTopics extends StatefulWidget {
  const AddNewTopics({Key? key}) : super(key: key);

  @override
  State<AddNewTopics> createState() => _AddNewTopicsState();
}

class _AddNewTopicsState extends State<AddNewTopics> {
  final List<String> labels = <String>['Easy', 'Medium', 'Hard'];

  String selected = 'Easy';
  int initial = 0;
  final NewTopicsController controller = Get.find();

  bool validate = false;
  // ignore: prefer_final_fields
  // DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  void initState() {
    DatabaseHelper.instance.initialiseDatabase().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController dateController = TextEditingController(
    text: ReviseDateUtil.formattedCurDate,
  );

  @override
  void dispose() {
    nameController.dispose();
    infoController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    double width = mq.size.width;
    double height = mq.size.height;
    double hPadding = width * 0.05;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios)),
          ),
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Add New Topic',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: hPadding, right: hPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  'Title\*',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    errorText: validate ? 'Topic name can\'t be empty' : null,
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                width: width * 0.9,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: infoController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                width: width * 0.9,
                //height: height * 0.2,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  'Select Date (optional)',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019),
                          lastDate: DateTime(2050),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            dateController.text =
                                ReviseDateUtil.newFormat.format(selectedDate);
                          }
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 40,
                      ),
                    ),
                    hintText: ReviseDateUtil.formattedCurDate,
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: ToggleSwitch(
                  totalSwitches: 3,
                  initialLabelIndex: initial,
                  borderColor: const [Colors.grey],
                  borderWidth: 1,
                  cornerRadius: 12,
                  labels: labels,
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Colors.black,
                  fontSize: 14,
                  activeBgColors: const [
                    [Colors.lightGreen],
                    [Colors.yellow],
                    [Colors.redAccent]
                  ],
                  onToggle: (index) {
                    setState(() {
                      initial = index;
                    });
                    selected = labels[index];
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Center(
                child: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text('Add New Topic'),
                  ),
                  onPressed: () async {
                    setState(() {
                      validate = nameController.text.isEmpty;
                    });
                    if (validate == false) {
                      //String curDate = ReviseDateUtil.formattedCurDate;
                      List<String> temp =
                          ReviseDateUtil().revisionDates(difficulty: selected);
                      Topics newTopic = Topics(
                          difficulty: selected,
                          title: nameController.text,
                          curDate: dateController.text,
                          info: infoController.text,
                          revDate1: temp[0],
                          revDate2: temp[1],
                          revDate3: temp[2],
                          revDate4: temp[3],
                          revDate5: temp.length >= 5 ? temp[4] : null,
                          revDate6: temp.length == 6 ? temp[5] : null);
                      await DatabaseHelper.instance
                          .insertTopic(newTopic)
                          .then((value) {
                        DatabaseHelper.instance.dsNewTopic();
                        controller.fetchTopics();
                        // controller.addTopicToList(newTopic);
                      }).whenComplete(() => Get.back());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff1B4EE5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
