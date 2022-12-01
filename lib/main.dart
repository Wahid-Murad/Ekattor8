import 'package:ekattor_8/dropdown.dart';
import 'package:ekattor_8/homepage.dart';
import 'package:ekattor_8/login.dart';
import 'package:ekattor_8/routine.dart';
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
      home: HomePage(),
    );
  }
}

