import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/attendance_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var attendance;
  SharedPreferences? sharedPreferences;
  var attendanceDate;
  var dt;
  var d12;
  var month;
  String ? selectedValue;
  var lastIndex;


  var currentMonth=DateFormat.MMMM().format(DateTime.now());

  // var now = DateTime.now();
  // var current_mon =now.month;
//    var month = DateTime.now();
//  final formatted = formatDate(month, [mm]);

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
        attendanceDate = int.parse(data["timestamp"]);
          dt = DateTime.fromMillisecondsSinceEpoch(attendanceDate * 1000);
          //d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
          d12 = DateFormat('EEEE').format(dt);
          month=DateFormat.MMMM().format(dt);
          print(month);
          // print(currentMonth);
          if(selectedValue==null){
             Attendance attendancedemo = Attendance(
          id: data["id"],
          status: data["status"],
          timestamp: d12,
        );
        setState(() {
          attendanceDataDemo.add(attendancedemo);
        });
          }
          if(selectedValue==month){
             Attendance attendancedemo = Attendance(
          id: data["id"],
          status: data["status"],
          timestamp: d12,
        );
        setState(() {
          attendanceDataDemo.add(attendancedemo);
        });
          }
      }
      lastIndex=attendanceDataDemo.length;
          print(lastIndex);
    }
  }

  @override
  void initState() {
    fetchAttendance();
    super.initState();
  }

  final List<String> items = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Auguest',
    'September',
    'October',
    'November',
    'December',
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
                            'Attendance',
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
            Container(
              height: MediaQuery.of(context).size.height * 0.24,
              child: ListView.builder(
                  itemCount: attendanceData.length,
                  // shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
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
                            child:  DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Month",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF34B5FF),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,            
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
        ),
        iconSize: 20,
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.blue,
        buttonHeight: 40,
        buttonWidth: 160,
        buttonPadding: const EdgeInsets.only(left: 6, right: 6),
        buttonDecoration: BoxDecoration(
          color: Color(0XFFE8F6FF),//
          borderRadius: BorderRadius.circular(2),
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
        dropdownMaxHeight: 180,
        dropdownWidth: 160,
        dropdownPadding: null,
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
                        ],
                      ),
                    );
                  }),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.54,
                child: ListView.builder(
                    itemCount: attendanceDataDemo.length,
                      shrinkWrap: true,
                             //physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Padding(
                          padding: const EdgeInsets.only( left: 10),
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
                                  // attendanceDataDemo.length==lastIndex ?Container(height: 2,):
                                Image.asset(
                                    'images/dot2.PNG',
                                  ),
                                ],
                              ),
                              // Text('${attendanceDataDemo.length}'),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    '${attendanceDataDemo[index].timestamp}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),

                              attendanceDataDemo[index].status == "1"
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10,bottom: 25),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color:
                                              Color.fromARGB(255, 196, 245, 219),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Present",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 86, 238, 10)),
                                        )),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 10,bottom: 25),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color:
                                              Color.fromARGB(255, 247, 213, 224),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Absent",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.pink),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
