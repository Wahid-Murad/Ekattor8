import 'dart:convert';

import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/subject_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var subject;
  SharedPreferences? sharedPreferences;

  List<SubjectModel> subjectData = [];
  List<Subject> subjectDataDemo = [];

  fetchSubject() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/subjects";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      subject = jsonDecode(response.body);
      SubjectModel subjectModel = SubjectModel(
        classId: subject['class_id'],
        className: subject['class_name'],
        schoolId: subject['school_id'],
        sessionId: subject['session_id'],
        subjects: [],
      );
      setState(() {
        subjectData.add(subjectModel);
      });

      for (var data in subject["subjects"]) {
        Subject subjectdemo = Subject(id: data["id"], name: data["name"]);
        setState(() {
          subjectDataDemo.add(subjectdemo);
        });
      }
    }
  }

  @override
  void initState() {
    fetchSubject();
    super.initState();
  }

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
                            'Subject',
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // height: MediaQuery.of(context).size.height *subjectDataDemo.length*0.12,// 0.63
                width: MediaQuery.of(context).size.width * 0.90,
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              "Name",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              "Class",
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
                              subjectDataDemo.length *
                              0.082, //0.55,
                          child: ListView.builder(
                            itemCount: subjectDataDemo.length,
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
                                      children: [
                                        Text(
                                          "${subjectDataDemo[index].name}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF7C7F8D)),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${subject['class_name']}",
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
          ],
        ),
      ),
    );
  }
}
