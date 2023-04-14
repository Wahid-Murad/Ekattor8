import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/marks_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MarksPage extends StatefulWidget {
  const MarksPage({super.key});

  @override
  State<MarksPage> createState() => _MarksPageState();
}

class _MarksPageState extends State<MarksPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var marks;
  var count = 0;
  var examcategory;
  dynamic totalMark = 0;
  dynamic averageMark = 0;
  String averageMarkString="0";
  String? selectedValue;
  SharedPreferences? sharedPreferences;

  List<MarksModel> marksData = [];
  List<ExamMark> examMarkData = [];
  List<ExamCategory> examCategoryData = [];
  List<Subject> marksDataDemo = [];

  fetchMarks() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/marks";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      marks = jsonDecode(response.body);
      MarksModel marksModel = MarksModel(
        classId: marks['class_id'],
        className: marks['class_name'],
        sectionId: marks['section_id'],
        sectionName: marks['section_name'],
        schoolId: marks['school_id'],
        sessionId: marks['session_id'],
        examMarks: [],
        examCategories: [],
      );
      setState(() {
        marksData.add(marksModel);
      });

      for (var exammark in marks["exam_marks"]) {
        ExamMark exammarksdemo = ExamMark(
          examId: exammark['exam_id'],
          examCategoryId: exammark['exam_category_id'],
          comment: exammark['comment'],
          subjects: [],
        );
        setState(() {
          examMarkData.add(exammarksdemo);
        });
      }
        for (examcategory in marks["exam_categories"]) {
        ExamCategory examCategory = ExamCategory(
          examCategoryId: examcategory['exam_category_id'],
          examCategoryName: examcategory['exam_category_name'],
        );
        setState(() {
          examCategoryData.add(examCategory);
        });
      }

      
      for (var exammarks in marks["exam_marks"]) {
        totalMark=0;
        count=0;
        for (var data in exammarks["subjects"]) {
          if(exammarks['exam_category_id']==selectedValue){
            Subject marksdemo = Subject(
            subjectId: data['subject_id'],
            subjectName: data['subject_name'],
            marks: data['marks'],
          );
          setState(() {
            count++;
            marksDataDemo.add(marksdemo);
          });
          totalMark = totalMark + (double.parse(data["marks"]));
          averageMark = (totalMark / count);
          averageMarkString = averageMark.toStringAsFixed(0);
          print(totalMark);
          print(averageMark);
        }
      }
          }
    }
  }

  @override
  void initState() {
    fetchMarks();
    super.initState();
  }

  static var examCategoryName = [
    '1',
    '2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DemoDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                color: Color(0XFF00A3FF),
                height: MediaQuery.of(context).size.height * 0.22,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 30),
                      child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 18,
                            ),
                          )),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 30),
                          child: Text(
                            'Marks',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              clipper: MyCustomClipper(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Select a Exam",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF0BA6FE),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    items: examCategoryName
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Center(
                                child: Text(
                                  item.replaceFirst(
                                      item[0], item[0].toUpperCase()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    style: TextStyle(
                        fontSize: 20, color: Colors.white), //white color
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        marksDataDemo.clear();
                        Colors.blue;
                      });
                      fetchMarks();
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                    ),
                    iconSize: 16,
                    iconEnabledColor: Color(0XFF0DA6FD),
                    iconDisabledColor: Color(0XFF0DA6FD),
                    buttonHeight: 40,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 6, right: 6),
                    buttonDecoration: BoxDecoration(
                      color: Color(0XFFE7F5FE),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 160,
                    dropdownWidth: 160,
                    dropdownPadding: null,
                    // selectedItemHighlightColor: Colors.white,//
                    //  focusColor: Colors.white,
                    // itemSplashColor: Colors.white,
                    // itemHighlightColor: Colors.white,
                    // buttonSplashColor: Colors.white,
                    // buttonHighlightColor: Colors.white,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(10),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Class",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            // Spacer(),
                            Text(
                              "Subject",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Mark",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: MediaQuery.of(context).size.height *
                              marksDataDemo.length *
                              0.082, //0.55,
                          child: ListView.builder(
                            itemCount: marksDataDemo.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${marks['class_name']}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF7C7F8D)),
                                        ),
                                        // Spacer(),
                                        Text(
                                          "${marksDataDemo[index].subjectName}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF7C7F8D)),
                                        ),
                                        Text(
                                          "${marksDataDemo[index].marks}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF7C7F8D)),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 23,
                                      thickness: 0.8,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: CircularPercentIndicator(
                animation: true,
                radius: 90,
                lineWidth: 18,
                percent: (averageMark.toDouble() / 100),
                progressColor: Color(0XFF00A3FF),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text("$averageMarkString %"),
                // center: Text(averageMark), //$averageMark
              ),
            ),
          ],
        ),
      ),
    );
  }
}
