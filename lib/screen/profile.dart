import 'package:dotted_border/dotted_border.dart';
import 'package:ekattor_8/topbar/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool _rememberMe=false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
               Stack(
                 children: [
                   Container(
                    width: double.infinity,
                    height: 240,
                     child: ClipPath(
               clipper: CustomShape(),
             child: Container(
             height: 200,
             color: Colors.blue,
        ),
            ),
              ),
                   Positioned(
                    left: 150,
                    top: 130,
                    child: Image.asset('images/user2.PNG',height: 100,width: 100,),
                   ),
                   Positioned(
                    left: 190,
                    top: 215,
                    child: Icon(Icons.verified,color: Colors.blue,),
                   ),
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 40,top: 5),
                 child: Text("Jony Bristow",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 25,top: 3),
                 child: Text("University of Michigan",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,),),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 25,right: 20,top: 10),
                 child: Divider(
                  height: 5,
                  thickness: 1,
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.only(top: 15,left: 40,bottom: 20),
                 child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  child: Center(child: Text("Student Profile Image",style: GoogleFonts.roboto(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold),)),
                 ),
               ),

               Row(
                children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 18,right: 18),
                   child: InkWell(
                    onTap: (){

                    },
                     child: Text("Upload File",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600),
                     ),
                   ),
                 ), 
                 Padding(
                   padding: const EdgeInsets.only(left: 70,right: 10),
                   child: InkWell(
                    onTap: (){

                    },
                     child: Text("Preview",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600),
                     ),
                   ),
                 ), 
                 Padding(
                   padding: const EdgeInsets.only(left: 40,right: 20),
                   child: InkWell(
                    onTap: (){

                    },
                     child: Text("Delete",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.red),
                     ),
                   ),
                 ), 
                ],
               ),
               Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      strokeWidth: 2,
                      strokeCap: StrokeCap.butt,
                      color: Colors.black12,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Icon(Icons.cloud_upload_outlined,color: Colors.black26,),
                              ),
                              Text("Upload an Image",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                    child: Container(
                      width: 150,
                      height: 150,
                       decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                      child: Image.asset('images/user2.PNG',height: 20,width: 100,),
                    ),
                  ),
                ],
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 20,left: 40),
                 child: Text("Personal Info",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.bold),),
               ),

                    Padding(
                 padding: const EdgeInsets.only(top: 15,left: 20,),
                 child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  child: Center(child: Text("Basic Info",style: GoogleFonts.roboto(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold),)),
                 ),
               ),


               
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Full Name",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  )),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "Jony Bristow",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Email",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  )),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "student@domain.com",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),
                           
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Phone Number",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  )),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "+00(00)12345-6789",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Gender",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  ),
                  ),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Align(
                              alignment: Alignment.centerLeft,
                               child: Row(
                                 children: [
                                   Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                       boxShadow: [
                                        BoxShadow(
                                        color: Colors.black45,
                                         blurRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                   ],
                                    ),
                                     width: 93,
                                     height: 40,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Icon(Icons.radio_button_checked,size: 15,),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Female"),
                                        ],
                                      ),
                                   ),
                                   SizedBox(
                                    width: 20,
                                   ),
                                   Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                       boxShadow: [
                                        BoxShadow(
                                        color: Colors.black45,
                                         blurRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                   ],
                                    ),
                                     width: 93,
                                     height: 40,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Icon(Icons.radio_button_checked,size: 15,color: Colors.blue,),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Male"),
                                        ],
                                      ),
                                   ),
                                   SizedBox(
                                    width: 20,
                                   ),
                                   Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                       boxShadow: [
                                        BoxShadow(
                                        color: Colors.black45,
                                         blurRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                   ],
                                    ),
                                     width: 93,
                                     height: 40,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Icon(Icons.radio_button_checked,size: 15,),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Others"),
                                        ],
                                      ),
                                   ),
                                 ],
                               ),
                             ),
                           ),

                            Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Bio",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  ),
                  ),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 130,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),
                                  hintMaxLines: 16,            
                                ),
                              ),
                             ),
                           ),

                  Padding(
                 padding: const EdgeInsets.only(top: 20,left: 40),
                 child: Text("Address",style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.bold),),
               ),

                Padding(
                 padding: const EdgeInsets.only(left: 40,bottom: 20,top: 5),
                 child: Container(
                  width: 170,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  child: Center(child: Text("Student Address",style: GoogleFonts.roboto(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold),)),
                 ),
               ),

                     Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Location",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  ),
                  ), 
                      
                      Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 10),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "United Kingdom",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  hintMaxLines: 16,            
                                ),
                              ),
                             ),
                           ),

                   

                             Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "London",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),
                                  hintMaxLines: 16,            
                                ),
                              ),
                             ),
                           ),

                            Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "State",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),
                                  hintMaxLines: 16,            
                                ),
                              ),
                             ),
                           ),


                            Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Address Line 1",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  )),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "45 Roker Terrace, Latheronwheel",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),

                            Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Address Line 2",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  )),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "Your Address",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),

                            Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Zip Code",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,),),
                  )),
                           SizedBox(
                            height: 15,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  hintText: "A432QEW",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),
                           
                          Row(
                            children: [
                              Padding(
                                 padding: const EdgeInsets.only(right: 20,bottom: 20,left: 120),
                                 child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                     boxShadow: [
                                      BoxShadow(
                                      color: Colors.black45,
                                       blurRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                 ],
                                  ),
                                  child: Center(child: Text("Cancel",style: GoogleFonts.roboto(fontSize: 14),)),
                                 ),
                              ),

                              Padding(
                             padding: const EdgeInsets.only(right: 20,bottom: 20),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                                
                              ),
                              child: Center(child: Text("Save Changes",style: GoogleFonts.roboto(fontSize: 14,color: Colors.white),)),
                             ),
                          ),
                            ],
                          ),

                          Padding(
                                 padding: const EdgeInsets.only(right: 20,bottom: 20,left: 20),
                                 child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                     boxShadow: [
                                      BoxShadow(
                                      color: Colors.black45,
                                       blurRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                 ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20,left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Privacy",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                                        child: Divider(
                                        height: 5,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20,left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Who can see your profile photo?",style: GoogleFonts.roboto(fontSize: 12,color: Colors.black54),
                                          ),
                                        ),
                                      ),

                                       Padding(
                             padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 15),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                 boxShadow: [
                                  BoxShadow(
                                  color: Colors.black45,
                                   blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                             ],
                              ),
                              height: 50,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20),
                                  prefixIcon: Icon(Icons.lock_outline_rounded,size: 15,color: Colors.black,),
                                  hintText: "Only Me",
                                  suffixIcon: Icon(Icons.arrow_drop_down,size: 18,color: Colors.black,),
                                  hintStyle: GoogleFonts.roboto(fontSize: 12,),            
                                ),
                              ),
                             ),
                           ),

                           Image.asset('images/privacy.PNG',height: 200,),
                                    ],
                                  ),
                                 ),
                              ),
                        

                         Padding(
                                 padding: const EdgeInsets.only(right: 20,bottom: 20,left: 20),
                                 child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                     boxShadow: [
                                      BoxShadow(
                                      color: Colors.black45,
                                       blurRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                 ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20,left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Delete Your Account",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                                        child: Divider(
                                        height: 5,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                      child: Text("When you delete your account lose accessis Front account services and we permanentlly delete your personal data.You cante cancel the deletion for 14 days.",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400),),
                                    ),
                             Container(
                            child: Row(
                             children: [
                              Theme(
                                data: ThemeData(unselectedWidgetColor: Colors.black45), 
                                child: Checkbox(
                                  value: _rememberMe,
                                  checkColor: Colors.green,
                                  activeColor: Colors.white, 
                                  onChanged: (value) {
                                    setState(() {
                                    
                                    });
                                  }
                                  ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text("With your Pro account, you can disable\n ads across the site",style: GoogleFonts.roboto(color: Colors.black54,fontSize: 11),),
                                  ),                      
                             ],
                            ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(right: 20,bottom: 20,top: 40,left: 200),
                             child: Container(
                              alignment: Alignment.centerLeft,
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                                
                              ),
                             child: Center(child: InkWell(
                              onTap: (){
                                
                              },
                               child: Text("Delete",style: GoogleFonts.roboto(fontSize: 15,color: Colors.white),
                               ),
                             ),
                             ),
                             ),
                             ),
                                    ],
                                  ),
                                 ),
                              ),
                              
            ],
          ),
        ),
      ),
    );
  }
}