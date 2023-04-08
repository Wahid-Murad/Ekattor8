import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/exams_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var exams;
  String? selectedValue;
  SharedPreferences? sharedPreferences;

  List<ExamsModel> examsData = [];
  List<Exam> examsDataDemo = [];

  fetchExams() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/exam_list";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      exams = jsonDecode(response.body);
      ExamsModel examsModel = ExamsModel(
        classId: exams['class_id'],
        className: exams['class_name'],
        sectionId: exams['section_id'],
        sectionName: exams['section_name'],
        schoolId: exams['school_id'],
        sessionId: exams['session_id'],
        exams: [],
      );
      setState(() {
        examsData.add(examsModel);
      });

      for (var data in exams["exams"]) {
        if (selectedValue == null) {
          Exam examsdemo = Exam(
            id: data["id"],
            name: data["name"],
            examType: data["exam_type"],
            subjectId: data["subject_id"],
            subjectName: data["subject_name"],
            startingTime: data["starting_time"],
            endingTime: data["ending_time"],
            totalMarks: data["total_marks"],
            status: data["status"],
          );

          setState(() {
            examsDataDemo.add(examsdemo);
          });
        }

        if (data["status"] == selectedValue) {
          Exam examsdemo = Exam(
            id: data["id"],
            name: data["name"],
            examType: data["exam_type"],
            subjectId: data["subject_id"],
            subjectName: data["subject_name"],
            startingTime: data["starting_time"],
            endingTime: data["ending_time"],
            totalMarks: data["total_marks"],
            status: data["status"],
          );

          setState(() {
            examsDataDemo.add(examsdemo);
          });
        }
      }
    }
  }

  @override
  void initState() {
    fetchExams();
    super.initState();
  }

  static var examStatus = [
    'Expired',
    'Upcoming',
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
                //   alignment: FractionalOffset.center,
                // transform: new Matrix4.identity()
                //   ..rotateZ(0 * 3.1415927 / 360),
                height: MediaQuery.of(context).size.height * 0.22,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 30),
                      child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                            //  drawer: DemoDrawer(),
                            // Scaffold.of(context).openDrawer();
                            // Navigator.of(context).pop();//MaterialPageRoute(builder: (context)=> )
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
                            'Exam',
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
                    items: examStatus
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
                        examsDataDemo.clear();
                        Colors.blue;
                      });

                      fetchExams();
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 5),
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
              padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.68,
                child: ListView.builder(
                  itemCount: examsDataDemo.length,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Exam",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${examsDataDemo[index].name}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF7C7F8D)),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 15,
                                thickness: 1,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Status",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${examsDataDemo[index].status}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF7C7F8D)),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 12,
                                thickness: 0.5,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Starting Time",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${examsDataDemo[index].startingTime}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF7C7F8D)),
                                    ),
                                  ],
                                ),
                              ),

                              Divider(
                                height: 12,
                                thickness: 0.5,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Ending Time",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${examsDataDemo[index].endingTime}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF7C7F8D)),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 10, right: 10),
                              //   child: Row(
                              //     //"${bookDataDemo[index].name}",
                              //     children: [
                              //       Text(
                              //         "",
                              //         style: GoogleFonts.poppins(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w500,color: Color(0XFF11152C)),
                              //       ),
                              //       Spacer(),
                              //       Text(
                              //         "${examsDataDemo[index].startingTime}",
                              //         style: GoogleFonts.poppins(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w500,color: Color(0XFF7C7F8D)),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10),
                              //   child: Align(
                              //     alignment: Alignment.bottomLeft,
                              //     child: Text(
                              //       "${examsDataDemo[index].status}",
                              //       style: GoogleFonts.poppins(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w500,color: Color(0XFF7C7F8D)),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
