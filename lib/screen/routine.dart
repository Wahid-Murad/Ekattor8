import 'dart:convert';
import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:ekattor_8/consts/dropdown.dart';
import 'package:ekattor_8/model/routine_model.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
    var routine;
  SharedPreferences ? sharedPreferences;

  List <RoutineModel> routineData=[];
  List <Routine> routineDataDemo=[];

  fetchRoutine() async {
     sharedPreferences=await SharedPreferences.getInstance();
     dynamic token = sharedPreferences!.getString("access_token");

     print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/routine";

     final response = await http.post(Uri.parse(url), headers: {
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'Authorization': 'Bearer $token',
     });

     if (response.statusCode == 201) {
      print(response.body);
      routine = jsonDecode(response.body);
      RoutineModel routineModel = RoutineModel(
          classId: routine["class_id"],
          className: routine["class_name"],
          sectionId: routine["section_id"],
          sectionName: routine["section_name"],
          schoolId: routine["school_id"],
          sessionId: routine["session_id"]
      );
            setState(() {
          routineData.add(routineModel);
        });

       for( var data in routine["routines"]){ //for in loop
         Routine routinedemo = Routine(
         id: data["id"],
         subjectId: data["subject_id"],
         subjectName: data["subject_name"],
         startingTime: data["starting_time"],
         endingTime: data["ending_time"],
         day: data["day"],
         teacherId: data["teacher_id"],
         teacherName: data["teacher_name"]
       );
             setState(() {
          routineDataDemo.add(routinedemo);
        });
       }
    }
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
     body: Column(
          children: [
            TopBar(),
             Padding(
               padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
               child: Row(
                 children: [             
                     Stack(
                       children: [
                         Padding(
                              padding: const EdgeInsets.only(left: 250),
                              child: AppDropDown(),
                               ), 
                         Positioned(
                          left: 10,
                           child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                         boxShadow: [
                                          BoxShadow(
                                          color: Colors.black45,
                                           blurRadius: 0.1,
                                          offset: Offset(0, 0),
                                        ),
                                     ],
                                      ),
                                      width: 220,
                                      height: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        style: GoogleFonts.roboto(),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(top: 15),
                                          prefixIcon: Icon(Icons.search,color: Colors.black38,size: 20,),
                                          hintText: "Search",
                                          hintStyle: GoogleFonts.roboto(fontSize: 14,),
                                        ),
                                      ), 
                                     ),
                         ),
                       ],
                     ),
                                                                               
                 ],
               ),
             ),
                  
                    Container(
                  height: 400,
                  width: double.infinity,
                 child: ListView.builder(
            itemCount: routineData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) { 
                   return Container(
                    color: Colors.black,
                    width: 200,
                    height: 100,
                    child: Column(
                      children: [
                       Text("Hello "),
                      ],
                    ),
                   );
                      },
                ),
                ), 
          ],
        ),
       
    );
  }
}

              