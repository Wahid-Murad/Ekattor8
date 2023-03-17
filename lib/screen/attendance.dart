import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:ekattor_8/consts/dropdown2.dart';
import 'package:ekattor_8/consts/dropdown3.dart';
import 'package:ekattor_8/model/attendance_model.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  var attendance;
  SharedPreferences? sharedPreferences;

  List<AttendanceModel> attendanceData = [];
  List<Attendance> attendanceDataDemo = [];

  fetchAttendance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/attendance";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      attendance = jsonDecode(response.body);
      AttendanceModel attendanceModel = AttendanceModel(
        classId: attendance['class_id'],
        className: attendance['class_name'],
        schoolId: attendance['school_id'],
        sectionId: attendance['section_id'],
        sectionName: attendance['section_name'],
        sessionId: attendance['session_id'],
        attedances: [],
      );
      setState(() {
        attendanceData.add(attendanceModel);
      });

      for (var data in attendance["attedances"]) {
        Attendance attendancedemo = Attendance(
          id: data["id"],
          status: data["status"],
          timestamp: data["timestamp"],
        );
        setState(() {
          attendanceDataDemo.add(attendancedemo);
        });
      }
    }
  }

  @override
  void initState() {
    fetchAttendance();
    super.initState();
  }

  static var items = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TopBar(
              title: "Attendance",
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.24,
            child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Image.asset('images/user2.PNG',
                                    height: 80, width: 80, fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 10),
                                        child: Text(
                                          "Class ${attendanceData[index].className}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: Text(
                                      "Section ${attendanceData[index].sectionName}",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: Row(
                            children: [
                              DropDown2(),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: DropDown3(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),


          Container(
            height: MediaQuery.of(context).size.height * 0.52,
            child: ListView.builder(
              itemCount: attendanceDataDemo.length,
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.52,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height*0.10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Icon(
                                        Icons.circle_outlined,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ),
                                    Image.asset('images/dot2.PNG',),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      '${items[index]}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 196, 245, 219),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Present",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromARGB(255, 86, 238, 10)),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: 80,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 247, 213, 224),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Absent",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.pink),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
