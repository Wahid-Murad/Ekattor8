import 'dart:convert';
import 'package:ekattor_8/model/user_model.dart';
import 'package:ekattor_8/screen/homepage.dart';
import 'package:ekattor_8/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<UserModel> userList = [];
  late UserModel userModel;
  String? token;
  bool _rememberMe = false;
  var tcVisibility = false;
  SharedPreferences? sharedPreferences;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String Link = "https://demo.creativeitem.com/test/Ekattor8/api/login";

  getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var response = await http.post(
      Uri.parse(Link),
      body: map,
      //headers: DefaultToken.defaultHeader,
    );
    
     final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        sharedPreferences!.setString("access_token", data["token"]);
      });
      token = sharedPreferences!.getString("access_token");
      print("Token Saved $token");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage()));
      Fluttertoast.showToast(msg: "Login Successful");
    } else {
      Fluttertoast.showToast(msg: "Login Failed");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  //  isLogin() async{
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   token=sharedPreferences!.getString("token");
  //   try{
  //   if(token!.isNotEmpty){
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav()));
  //   }
  //   else{
  //        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
  //        print("Token is Null"); 
  //   }
  //   }
  //   catch(e){
  //     print("Exception is $e");
  //   }
  // }

  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("access_token");
    try{
    if (token == null) {
      print("Token is Null");
    } else {
      Fluttertoast.showToast(msg: "Already Logged In");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage()));
      // return ProfilePage();
    //   navigator.pushAndRemoveUntil(
    // MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
    // ModalRoute.withName('/'),

    }
    }
    catch(e){
      print("Exception is $e");
    }
  }

  @override
  void initState() {
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 110, vertical: 60),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('images/cap.png'),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "ekattor",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: double.infinity,
              padding: EdgeInsets.only(
                left: 30,
                top: 170,
                right: 28,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter Your Credentials to Access Your Account",
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white, //Color(0xFFFFFFFF)
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          height: 50,
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black38,
                                size: 17,
                              ),
                              hintText: "Example@domain.com",
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          height: 50,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.roboto(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black54,
                                size: 17,
                              ),
                              hintText: "6+ Strong Character",
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: InkWell(
                                  onTap: () {
     setState(() {
         tcVisibility = true;
    });
                                  },
                                  child: Icon(
                                    Icons.visibility_off,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.black45),
                                child: Checkbox(
                                    value: _rememberMe,
                                    checkColor: Colors.green,
                                    activeColor: Colors.white,
                                    onChanged: (value) {
                                      setState(() {
                                        //_rememberMe=value;
                                      });
                                    }),
                              ),
                              Text(
                                "Remember me",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forget Password?",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          //   if(emailController==null || passwordController==null){
                          //      Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => LoginPage()));
                          //   }
                          //  else if(emailController==null && passwordController==null){
                          //      Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => LoginPage()));
                          //   }
                            getLogin();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 25),
                            width: 400,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
