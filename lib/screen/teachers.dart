import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/model/teachers_model.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
   var teacher;
    String? selectedValue;
  SharedPreferences? sharedPreferences;

  List<TeachersModel> teacherData = [];
  List<Teacher> teacherDataDemo = [];

  fetchTeacher() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/teacher_list";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      teacher = jsonDecode(response.body);
      TeachersModel teachersModel = TeachersModel(
        classId: teacher['class_id'],
        className: teacher['class_name'],
        schoolId: teacher['school_id'],
        sessionId: teacher['session_id'],
        sectionId: teacher['section_id'],
        sectionName: teacher['section_name'],
        teachers: [],
      );
      setState(() {
        teacherData.add(teachersModel);
      });

      for (var data in teacher["teachers"]) {
        if(selectedValue==null){
        Teacher teacherdemo = Teacher(
          id: data["id"],
          name: data["name"],
          departmentId: data["department_id"],
          departmentName: data["department_name"],
          schoolId:  data["school_id"],
          designation: data["designation"],
           );
        setState(() {
         teacherDataDemo.add(teacherdemo);
        });
        }

        if (data["department_name"] == selectedValue) {
        Teacher teacherdemo = Teacher(
          id: data["id"],
          name: data["name"],
          departmentId: data["department_id"],
          departmentName: data["department_name"],
          schoolId:  data["school_id"],
          designation: data["designation"],
           );
        setState(() {
         teacherDataDemo.add(teacherdemo);
        });
        }
        }
    }
  }

  @override
  void initState() {
    fetchTeacher();
    super.initState();
  }

  static var department = [
    'English',
    'Mathematics',
    'Bangla',
    'Drawing',
    // 'Physics',
    // 'GK',
    // 'Chemistry',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TopBar(
              title: "Teachers",
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 10),
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
                            "Department",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF0BA6FE),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  items: department
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: Text(
                                item.replaceFirst(item[0], item[0].toUpperCase()),
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
                  style: TextStyle(fontSize: 20, color: Colors.white), //white color
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      teacherDataDemo.clear();
                      Colors.blue;
                    });
          
                     fetchTeacher();
                  },
                  icon: Align(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                    ),
                  ),
                  iconSize: 20,
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
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10,bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Name",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "Designation",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: ListView.builder(
                          itemCount: teacherDataDemo.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 20,),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${teacherDataDemo[index].name}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${teacherDataDemo[index].designation}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
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
    );
  }
}
