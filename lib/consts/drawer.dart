import 'dart:convert';
import 'package:ekattor_8/model/subject_model.dart';
import 'package:ekattor_8/model/user_details_model.dart';
import 'package:ekattor_8/screen/attendance.dart';
import 'package:ekattor_8/screen/book.dart';
import 'package:ekattor_8/screen/exams.dart';
import 'package:ekattor_8/screen/fee.dart';
import 'package:ekattor_8/screen/issue_book.dart';
import 'package:ekattor_8/screen/login.dart';
import 'package:ekattor_8/screen/marks.dart';
import 'package:ekattor_8/screen/profile.dart';
import 'package:ekattor_8/screen/routine.dart';
import 'package:ekattor_8/screen/subject.dart';
import 'package:ekattor_8/screen/syllabus.dart';
import 'package:ekattor_8/screen/teachers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DemoDrawer extends StatefulWidget {
  const DemoDrawer({Key? key}) : super(key: key);

  @override
  State<DemoDrawer> createState() => _DemoDrawerState();
}

class _DemoDrawerState extends State<DemoDrawer> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var user;
  bool _rememberMe = false;
  SharedPreferences? sharedPreferences;

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.clear();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  List<UserDetailsModel> userData = [];
  fetchUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/user_details";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      user = jsonDecode(response.body);

      UserDetailsModel userDetailsModel = UserDetailsModel(
          id: user["id"],
          userId: user["user_id"],
          classId: user["class_id"],
          sectionId: user["section_id"],
          schoolId: user["school_id"],
          departmentId: user["department_id"],
          sessionId: user["session_id"],
          code: user["code"],
          parentName: user["parent_name"],
          name: user["name"],
          email: user["email"],
          role: user["role"],
          address: user["address"],
          phone: user["phone"],
          birthday: user["birthday"],
          gender: user["gender"],
          bloodGroup: user["blood_group"],
          photo: user["photo"],
          runningSession: user["running_session"],
          className: user["class_name"],
          sectionName: user["section_name"]);
      setState(() {
        userData.add(userDetailsModel);
      });
    }
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 90,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                  itemCount: userData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.network('${user['photo']}',
                              height: 60, width: 60, fit: BoxFit.cover),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: Text(
                              '${user['name']}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.verified,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 35, left: 100),
                            child: Text(
                              'Class ${user['class_name']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black45),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.1,
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage()));
              },
              leading: Icon(Icons.school),
              title: Text(
                "Student",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ExamsPage()));
              },
              leading: Icon(Icons.event_note_outlined),
              title: Text(
                "Exam",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FeePage()));
              },
              leading: Icon(Icons.payment),
              title: Text(
                "Fee",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MarksPage()));
              },
              leading: Icon(Icons.mode_edit_outline_outlined),
              title: Text(
                "Marks",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AttendancePage()));
              },
              leading: Icon(Icons.person_outlined),
              title: Text(
                "Attendance Report",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RoutinePage()));
              },
              leading: Icon(Icons.person_outlined),
              title: Text(
                "Routine",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SyllabusPage()));
              },
              leading: Icon(Icons.payment),
              title: Text(
                "Syllabus",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SubjectPage()));
              },
              leading: Icon(Icons.online_prediction_sharp),
              title: Text(
                "Subjects",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TeachersPage()));
              },
              leading: Icon(Icons.person_outlined),
              title: Text(
                "Teachers",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const BookPage()));
              },
              leading: Icon(Icons.menu_book),
              title: Text(
                "Book",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Container(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 15,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const IssueBookPage()));
              },
              leading: Icon(Icons.menu_book_sharp),
              title: Text(
                "Book Issue",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 145, bottom: 10, top: 15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Container(
                width: 20,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                ),
                child: InkWell(
                  onTap: () {
                    logout();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 20, top: 10),
                        child: Icon(
                          Icons.logout,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 10, top: 10),
                        child: Text(
                          "Log out",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
