import 'package:ekattor_8/screen/homepage.dart';
import 'package:ekattor_8/screen/login.dart';
import 'package:ekattor_8/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekattor 8',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

