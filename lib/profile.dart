import 'dart:convert';

import 'package:ekattor_8/custom_token.dart';
import 'package:ekattor_8/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
   List <UserModel> userList=[];
  late UserModel userModel;
 
   String Link="https://demo.creativeitem.com/test/Ekattor8/api/auth/login";
  getStudentDetails()async{
     var map=Map<String,dynamic>();
     var response=await http.post(Uri.parse(Link),
     body: map,
   headers: await CustomToken().getHeaderWithToken(),
    );
    if(response.statusCode==200){
      var item=jsonDecode(response.body);
      for(var data in item){
        userModel=UserModel.fromJson(data);
        setState(() {
          userList.add(userModel);
        });
      }
    }
  }

  @override
  void initState() {
    getStudentDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile")),
        leading: Text("${userList.length}"),
      ),
      body: Container(
       child: ListView.builder(
        shrinkWrap: true,
        itemCount: userList.length,
        itemBuilder: (context,index){
          return Container(
            child: Column(
              children: [
                Text("${userList[index].message}"),
                Text("${userList[index].token}"),
              ],
            ),
          );
        },
        ),
      ),
    );
  }
}