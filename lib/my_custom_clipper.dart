import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path>{
//4,2,4,2,width,*0.9 3
  @override
  Path getClip(Size size) {
   Path path=Path();
   path.lineTo(0, size.height/2);//2
   path.cubicTo(size.width/4, 3*(size.height/2), 3*(size.width/4), size.height/2, size.width,size.height*0.9);
   path.lineTo(size.width, 0);
   return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }
}