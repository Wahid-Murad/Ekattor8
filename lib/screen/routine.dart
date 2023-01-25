import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  SharedPreferences? sharedPreferences;
    final List<String> items = [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
  ];
  String ? selectedValue;

  List<RoutineModel> routineData = [];
  List<Routine> routineDataDemo = [];

  fetchRoutine() async {
    sharedPreferences = await SharedPreferences.getInstance();
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
          sessionId: routine["session_id"]);
      setState(() {
        routineData.add(routineModel);
      });

      for (var data in routine["routines"]) {
        if(data["day"]==selectedValue){
        Routine routinedemo = Routine(
            id: data["id"],
            subjectId: data["subject_id"],
            subjectName: data["subject_name"],
            startingTime: data["starting_time"],
            endingTime: data["ending_time"],
            day: data["day"],
            teacherId: data["teacher_id"],
            teacherName: data["teacher_name"]);
        setState(() {
          routineDataDemo.add(routinedemo);
        });
        }
      }
    }
  }

@override
  void initState() {
   fetchRoutine();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            title: "Routine",
          ),
      
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 240),
                      child: DropdownButtonHideUnderline(
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
                "Day",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,            
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ))
                          .toList(),
                value: selectedValue,
                onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                          routineDataDemo.clear();
                          routineData.clear();
                        });
                        fetchRoutine();
                },
                icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                ),
                iconSize: 20,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                buttonHeight: 45,
                buttonWidth: 100,
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
                          ),
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
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black38,
                              size: 20,
                            ),
                            hintText: "Search",
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Text(routineDataDemo.length.toString()),
          // Text("$widget.selectedValue"),
      
             //"${user['name']}"
      
              //(selectedValue=={routineDataDemo['day']}) ? 
              routineDataDemo.length!=0 ? 
            selectedDay(): Padding(
              padding: const EdgeInsets.only(top: 23),
              child: Image.asset('images/nodata.jpg',height: 190,),
            ),  
        ],
      ),
    );
  }
  selectedDay(){
    return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: MediaQuery.of(context).size.height * .65,
                child: GridView.builder(
                      itemCount: routineDataDemo.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 8.0 / 10.0,
                       crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {                    
                     return Column(
                       children: [
                        //if(routineDataDemo[index].day==selectedValue)
                         Padding(
                    padding: EdgeInsets.all(5),  
                    child: Card(
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Image.asset('images/user2.PNG',height: 75,width: double.infinity,),
                                  Padding(
                                        padding: const EdgeInsets.only(top: 6,),
                                        child: Center(
                                          child: Text(
                                            "${routineDataDemo[index].teacherName}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                        Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6),
                                        child: Center(
                                          child: Text(
                                            "Teacher",
                                            style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                     Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Divider(
                                          height: 10,
                                          thickness: 0.5,
                                        ),
                                      ),
                                      
                                        Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50, top: 10),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 12,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                              child: Text(
                                            "${routineDataDemo[index].subjectName}",
                                            style: GoogleFonts.robotoSerif(),
                                          )),
                                        ],
                                      ),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 52),
                                            child: Image.asset(
                                              'images/dote.png',
                                              height: 12,
                                            ),
                                          ),
                                          ),
                                           Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 50,
                                              ),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 12,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${routineDataDemo[index].startingTime}",
                                            style: GoogleFonts.robotoSerif(),
                                          ),
                                        ],
                                      ),
    
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 52),
                                            child: Image.asset(
                                              'images/dote.png',
                                              height: 12,
                                            ),
                                          ),
                                          ),
    
                                                Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 50,
                                              ),
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${routineDataDemo[index].day}".replaceFirst(routineDataDemo[index].day![0], routineDataDemo[index].day![0].toUpperCase()),
                                            style: GoogleFonts.robotoSerif(),
                                          ),
                                        ],
                                      ),         
                              ],
                            ),
                            ),
                            ),
                       ],
                     );
                      },
                    ),
              ),
            ),
          );
  }

}





