import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:ekattor_8/consts/dropdown.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {


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
             
                         
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      height: 800,
                       child: GridView(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Image.asset('images/pic1.PNG',width: double.infinity,height: 55,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(" Madison Aria",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4,bottom: 5),
                                  child: Text("Teacher",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w300),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
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
                                    padding: const EdgeInsets.only(left: 50,top: 10),
                                    child: Icon(Icons.circle_outlined,size: 12,color: Colors.green,),
                                  ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(child: Text("English",style: GoogleFonts.robotoSerif(),)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52),
                              child: Image.asset('images/dote.png',height: 12,),
                            )),
                               
                                 Row(
                            children: [
                                    Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50,),
                                    child: Icon(Icons.circle_outlined,size: 12,color: Colors.blue,),
                                  ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("9-10 am",style: GoogleFonts.robotoSerif(),),
                            ],
                          ),
              //      DottedLine(
              //       direction: Axis.vertical,
              //   lineLength: 3,
              //   lineThickness: 1.0,
              //   dashLength: 1.0,
              //   dashColor: Colors.red,
              //   //dashGradient: [Colors.red, Colors.blue],
              //   dashRadius: 0.0,
              //   dashGapLength: 4.0,
              //   //dashGapColor: Colors.transparent,
              //  // dashGapGradient: [Colors.red, Colors.blue],
              //   dashGapRadius: 0.0,
              // ),
              
                                Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52),
                              child: Image.asset('images/dote.png',height: 12,),
                            )),
                                
                          Row(
                            children: [
                                    Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50,),
                                    child: Icon(Icons.circle_outlined,size: 12,color: Colors.red,),
                                  ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Room-1",style: GoogleFonts.robotoSerif(),),
                            ],
                          ),
                               
                              ],
                            ),
                            color: Colors.white,
                          ),
                          Container(
                            child: Image.asset('images/routine.PNG',fit: BoxFit.cover,),
                            color: Colors.white,
                          ),
                          Container(
                            child: Image.asset('images/routine.PNG',fit: BoxFit.cover,),
                            color: Colors.white,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Image.asset('images/pic2.PNG',width: double.infinity,height: 55,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(" David Malan",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4,bottom: 5),
                                  child: Text("Teacher",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w300),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
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
                                    padding: const EdgeInsets.only(left: 50,top: 10),
                                    child: Icon(Icons.circle_outlined,size: 12,color: Colors.green,),
                                  ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(child: Text("Biology",style: GoogleFonts.robotoSerif(),)),
                            ],
                          ), 
              
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52),
                              child: Image.asset('images/dote.png',height: 12,),
                            ),
                            ),
              
              
                                 Row(
                            children: [
                                    Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50,),
                                    child: Icon(Icons.circle_outlined,size: 12,color: Colors.blue,),
                                  ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("2-3 pm",style: GoogleFonts.robotoSerif(),),
                            ],
                          ),
              
                                Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 52),
                              child: Image.asset('images/dote.png',height: 12,),
                            ),
                            ),
              
                            Row(
                            children: [
                                    Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50,),
                                    child: Icon(Icons.circle_outlined,size: 12,color: Colors.red,),
                                  ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Room-6",style: GoogleFonts.robotoSerif(),),
                            ],
                          ),
                              ],
                            ),
                            color: Colors.white,
                          ),
                        ],
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,  mainAxisExtent: 200, crossAxisSpacing: 10,mainAxisSpacing: 10),
                        ),
                     ),
                  ),
                ),
          ],
        ),
       
    );
  }
}

              