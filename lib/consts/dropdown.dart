import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/model/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppDropDown extends StatefulWidget {
  AppDropDown({super.key, this.selectText});

  String? selectText;


  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  final List<String> items = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
  ];
  String ? selectedValue;
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
      // If the server did return a 200 OK response,
      // then parse the JSON.
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
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "Day",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
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
           if(value==''){//test

           }
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down_outlined,
        ),
        iconSize: 20,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        buttonHeight: 45,
        buttonWidth: 90,
        buttonPadding: const EdgeInsets.only(left: 6, right: 6),
        buttonDecoration: BoxDecoration(
          color: Colors.blue,
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
        dropdownWidth: 100,
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
    );
  }
}
