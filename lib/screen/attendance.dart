import 'package:ekattor_8/consts/dropdown2.dart';
import 'package:ekattor_8/consts/dropdown3.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            title: "Attendance",
          ),
        Stack(
                 children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('images/user2.PNG',height: 80,width: 80,fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,left: 100),
                      child: Text("Marah Peterson",style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150,top: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.verified,color: Colors.blue,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45,left: 100),
                      child: Text("University Of Michigan",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 10),
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
              // ListView.builder(
              //   itemCount: 7,
              //   itemBuilder: (context, index) {
              //     return 
                       SingleChildScrollView(
                         child: Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 15,left: 10),
                               child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                                            children: [
                                             Text("Saturday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                                             Container(
                              width: 80,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                                ),
                                             ),
                                             Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: 80,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                  child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                                  ),
                              ),
                                             ),
                                           ],
                                         ),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 10),
                         child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                     children: [
                      Text("Sunday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                            ),
                        ),
                      ),
                    ],
                  ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 10),
                         child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                     children: [
                      Text("Monday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                            ),
                        ),
                      ),
                    ],
                  ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 10),
                         child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                     children: [
                      Text("Tuesday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                            ),
                        ),
                      ),
                    ],
                  ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 10),
                         child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                     children: [
                      Text("Wednesday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                            ),
                        ),
                      ),
                    ],
                  ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 10),
                         child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                     children: [
                      Text("Thusday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                            ),
                        ),
                      ),
                    ],
                  ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 10),
                         child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                     children: [
                      Text("Friday",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.w500),),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text("Present",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text("Absent",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white),)
                            ),
                        ),
                      ),
                    ],
                  ),
                       ),
                       
              //   }  
              //   ),

        ],
      ),
    );
  }
}