import 'dart:convert';

import 'package:ekattor_8/model/user_details_model.dart';
import 'package:ekattor_8/screen/attendance.dart';
import 'package:ekattor_8/screen/login.dart';
import 'package:ekattor_8/screen/profile.dart';
import 'package:ekattor_8/screen/routine.dart';
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

  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  var user;
  bool _rememberMe=false;
  SharedPreferences ? sharedPreferences;

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
  }

List <UserDetailsModel> userData=[];
  fetchUser() async {
    sharedPreferences=await SharedPreferences.getInstance();
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
          sectionName: user["section_name"]
        );
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
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              
              child: ListView.builder(
               itemCount: userData.length,
               shrinkWrap: true,
               itemBuilder: (context, index) {       
               return Stack(
                 children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.network('${user['photo']}',height: 70,width: 70,fit: BoxFit.cover),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20),
                      child: Text('${user['name']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200,top: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.verified,color: Colors.blue,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,//+Alignment(0, 0.4)
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50,left: 100),
                      child: Text('Class ${user['class_name']}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              );
               }
              ),
             
            ),
             Divider(
             height: 0,
             thickness: 0.1,
            ),

            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.person),
             title: Text("Parent") ,  
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
              },
             leading: Icon(Icons.cabin),
             title: Text("Student") ,  
            ),
            ListTile(
              onTap: (){
              },
             leading: Icon(Icons.expand),
             title: Text("Exam") ,  
            ),
            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.feed),
             title: Text("Fee") ,  
            ),
            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.mark_as_unread),
             title: Text("Marks") ,  
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AttendancePage()));
              },
             leading: Icon(Icons.person),
             title: Text("Attendance Report") ,  
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoutinePage()));
              },
             leading: Icon(Icons.person),
             title: Text("Routine"),  
            ),
            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.task),
             title: Text("Syllabus") ,  
            ),
            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.person),
             title: Text("Assignment") ,  
            ),
            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.event),
             title: Text("Event Calender") ,  
            ),
            ListTile(
              onTap: (){
                
              },
             leading: Icon(Icons.person),
             title: Text("Online Course") ,  
            ),
            ListTile(
              onTap: (){
              },
             leading: Icon(Icons.online_prediction),
             title: Text("Live Class") ,
            ),
          // MaterialButton(
          //   color: Colors.blue,
          //   onPressed: (){},
          //   child: Text("Logout"),
          //   ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 145,bottom: 10),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
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
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
                    logout();
                  },
                  child: Row(
                    children: [
                      Padding(
                      padding: const EdgeInsets.only(bottom: 10,left: 20,top: 10),
                      child: Icon(Icons.logout,size: 18,color: Colors.white,),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 10,left: 10,top: 10),
                      child: Text("Log out",style: GoogleFonts.roboto(fontSize: 15,color: Colors.white),),
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


//  Row(
//               children: [
//                 Text("Log out"),
//               ],
//             ),


        // child: ListView.builder(
        //     itemCount: userData.length,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {

        //         }
        // ), 