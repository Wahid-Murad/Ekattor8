// import 'package:ekattor_8/consts/drawer.dart';
// import 'package:ekattor_8/topbar/my_custom_clipper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TopBar extends StatefulWidget {
// TopBar({super.key,this.title,});
//    String ? title;
//   //  Icon ? icon;

//   @override
//   State<TopBar> createState() => _TopBarState();
// }

// class _TopBarState extends State<TopBar> {
//     GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();

//       bool _isDrawerOpen = false;

//   void _openDrawer() {
//     setState(() {
//       _isDrawerOpen = true;
//     });
//   }

//   void _closeDrawer() {
//     setState(() {
//       _isDrawerOpen = false;
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//         child: Container(
//           color: Color(0XFF00A3FF),
//         //   alignment: FractionalOffset.center,
//         // transform: new Matrix4.identity()
//         //   ..rotateZ(0 * 3.1415927 / 360),
//           height: MediaQuery.of(context).size.height*0.22,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 12,bottom: 30),
//                 child: InkWell(
//                   onTap: (){
//                      _openDrawer();
//                     //  drawer: DemoDrawer(),
//                     // Scaffold.of(context).openDrawer();
//                     // Navigator.of(context).pop();//MaterialPageRoute(builder: (context)=> )
                     
//                   },
//                   child: Container(
//                     width: 32,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Color(0XFF0096EB), //3c8ade
//                     ),
//                     child: Center(child: Icon(Icons.arrow_back,color: Colors.white,size: 18,)))),
//               ),
             
//               Align(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20,bottom: 30),
//                   child: Text('${widget.title}',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,
//                   ),
//                   ),
//                 )),
//             ],
//           ),
//         ),
//         clipper: MyCustomClipper(),
//     );
  
//   }
// }