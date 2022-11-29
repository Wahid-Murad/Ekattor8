import 'package:ekattor_8/constrain/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            margin: EdgeInsets.symmetric(horizontal: 110,vertical: 80),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('images/cap.png'),
                  ),
                SizedBox(
                  width: 3,
                ),
                Text("ekattor",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w500,),),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 200,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800,),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Enter Your Credentials to Access Your Account",style: GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w300,),),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                        children: [
                        Padding(
                         padding: const EdgeInsets.only(top: 10),
                         child: Container(
                          width: 140,
                          height: 45,
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
                            child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('images/facebook.png'),
                                  radius: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text("Log in With Facebook",style: GoogleFonts.roboto(fontSize: 11,),),
                              ),
                            ],
                          ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 10,left: 20),
                         child: Container(
                          width: 140,
                          height: 45,
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
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('images/gmail.png'),
                                  radius: 10,
                                ),
                              ),
                                  Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text("Log in With Google",style: GoogleFonts.roboto(fontSize: 11,),),
                              ),
                            ],
                          ),
                         ),
                       ),
                        ],
                       ),
                       SizedBox(
                        height: 5,
                       ),
                       Row(
                        children: [
                      //Divider(
                      //height: 50,
                      //thickness: 1,
                     //color: Colors.blue,
                    // ),
                    Image.asset('images/divider.png',width: 136,),
                    Text(" or  ",style: TextStyle(fontSize: 15,color: Colors.black),),
                    Image.asset('images/divider.png',width: 136,),      
                        ],
                       ),

                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text("Email",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400,),),
                        ),
                       SizedBox(
                        height: 10,
                       ),
                       Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,//Color(0xFFFFFFFF)
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
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(Icons.email,color: Colors.black38,size: 17,),
                            hintText: "Example@domain.com",
                            hintStyle: GoogleFonts.roboto(fontSize: 12,),

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
                        Text("Password",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400,),),
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
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(Icons.lock,color: Colors.black54,size: 17,),
                            hintText: "6+ Strong Character",
                            hintStyle: GoogleFonts.roboto(fontSize: 12,),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right:30),
                              child: Icon(Icons.visibility_off,size: 15,),
                            ),
                          ),
                        ),
                       ),
                       
                       Container(
                        child: Row(
                         children: [
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.black45), 
                            child: Checkbox(
                              value: _rememberMe,
                              checkColor: Colors.green,
                              activeColor: Colors.white, 
                              onChanged: (value) {
                                setState(() {
                                  // _rememberMe=value;
                                });
                              }
                              ),
                              ),
                              Text("Remember me",style: GoogleFonts.roboto(color: Colors.black54,fontSize: 12),),
                        Padding(
                          padding: const EdgeInsets.only(left: 61),
                          child: Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){}, child: Text("Forget Password?",style: GoogleFonts.roboto(color: Colors.black54,fontSize: 12),)),
                       ),
                        ),
                         ],
                        ),
                       ),
                       Container(
                        margin: EdgeInsets.only(top: 25),
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue, 
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10,),
                          child: Center(child: Text("Login",style: GoogleFonts.roboto(fontSize: 16,color: Colors.white),)),
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
    );
  }
}