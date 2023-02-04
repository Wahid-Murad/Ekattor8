import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatefulWidget {
TopBar({super.key,this.title,});
   String ? title;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        color: Colors.blue,
      //   alignment: FractionalOffset.center,
      // transform: new Matrix4.identity()
      //   ..rotateZ(0 * 3.1415927 / 360),
        height: 150,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 30,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent
                  ),
                  child: Center(child: Icon(Icons.arrow_back,color: Colors.white,size: 16,)))),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('${widget.title}',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,
                ),
                ),
              )),
          ],
        ),
      ),
      clipper: MyCustomClipper(),
    );
  }
}