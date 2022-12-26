import 'package:ekattor_8/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: LoginPage(),
      duration: 4000,
      imageSize: 600,
      imageSrc: "images/splash.png",

      //text: "Splash Screen",
      //textType: TextType.ColorizeAnimationText,
      // textStyle: TextStyle(
      //   fontSize: 40.0,
      // ),
      // colors: [
      //   Colors.purple,
      //   Colors.blue,
      //   Colors.yellow,
      //   Colors.red,
      // ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      //title: 'Splash screen Demo',
      debugShowCheckedModeBanner: false,
      home: example1,
    );
  }
}