import 'dart:ui';
import 'package:ekattor_8/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("            Ekattor 8",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
        elevation: 0,
      ),
     drawer: DemoDrawer(),
    );
  }
}