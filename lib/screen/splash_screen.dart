import 'dart:async';
import 'dart:math';

import 'package:ekattor_8/screen/login.dart';
import 'package:ekattor_8/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   SharedPreferences ? sharedPreferences;
     String ? token;

   isLogin()async{
    sharedPreferences=await SharedPreferences.getInstance();
    token= sharedPreferences!.getString("access_token"); 
    }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), (){
      isLogin() == true ?
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ProfilePage()))
         : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset('images/splash.png',width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
      ),
    );
  }
}