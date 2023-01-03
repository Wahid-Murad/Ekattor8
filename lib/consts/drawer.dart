import 'package:ekattor_8/screen/login.dart';
import 'package:ekattor_8/screen/routine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoDrawer extends StatelessWidget {
  const DemoDrawer({Key? key}) : super(key: key);

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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset('images/user.jpeg',height: 70,width: 70,fit: BoxFit.cover,),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text("Jony Bristow",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150,top: 40),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.verified,color: Colors.blue,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center+Alignment(0, 0.2),
                    child: Text("University of Michigan",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
                  ),
                ],
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
                
              },
             leading: Icon(Icons.person),
             title: Text("Attendance Report") ,  
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoutinePage()));
              },
             leading: Icon(Icons.person),
             title: Text("Routine") ,  
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
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