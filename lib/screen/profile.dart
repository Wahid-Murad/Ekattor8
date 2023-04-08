import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/user_details_model.dart';
import 'package:ekattor_8/screen/login.dart';
import 'package:ekattor_8/topbar/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var user;
  bool _rememberMe = false;
  SharedPreferences? sharedPreferences;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove('access_token');
  //   prefs.clear();
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
  // }

  List<UserDetailsModel> userData = [];
  fetchUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/user_details";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      user = jsonDecode(response.body);
      // for( var data in user){ //for in loop
      //   UserDetailsModel userDetailsModel = UserDetailsModel(
      //     id: data["id"],
      //     userId: data["user_id"],
      //     classId: data["class_id"],
      //     sectionId: data["section_id"],
      //     schoolId: data["school_id"],
      //     departmentId: data["department_id"],
      //     sessionId: data["session_id"],
      //     createdAt: data["created_at"],
      //     updatedAt: data["updated_at"],
      //     code: data["code"],
      //     parentName: data["parent_name"],
      //     name: data["name"],
      //     email: data["email"],
      //     role: data["role"],
      //     address: data["address"],
      //     phone: data["phone"],
      //     birthday: data["birthday"],
      //     gender: data["gender"],
      //     bloodGroup: data["blood_group"],
      //     photo: data["photo"],
      //     runningSession: data["running_session"],
      //     className: data["class_name"],
      //     sectionName: data["section_name"]
      //   );
      //   setState(() {
      //     userData.add(userDetailsModel);
      //   });
      // }
      // print(user['name']);
      UserDetailsModel userDetailsModel = UserDetailsModel(
          id: user["id"],
          userId: user["user_id"],
          classId: user["class_id"],
          sectionId: user["section_id"],
          schoolId: user["school_id"],
          departmentId: user["department_id"],
          sessionId: user["session_id"],
          // createdAt: user["created_at"],
          // updatedAt: user["updated_at"],
          code: user["code"],
          parentName: user["parent_name"],
          name: user["name"],
          email: user["email"],
          role: user["role"],
          address: user["address"],
          phone: user["phone"],
          birthday: user["birthday"],
          gender: user["gender"],
          bloodGroup: user["blood_group"],
          photo: user["photo"],
          runningSession: user["running_session"],
          className: user["class_name"],
          sectionName: user["section_name"]);
      setState(() {
        userData.add(userDetailsModel);
      });
    }
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  File? image; //profile update
  final picker = ImagePicker();

  Future getImageformGallery() async {
    print('on the way of gallery');
    // ignore: deprecated_member_use
    final pickedImage = await picker.getImage(source: ImageSource.camera);
     imageQuality: 25;
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('Image found');
        print('$image');
      } else {
        print('No image found');
      }
    });
  }

  Future saveChanges() async {
    setState(() {
      // onProgress = true;
    });
    final uri = Uri.parse(
        "https://demo.creativeitem.com/test/Ekattor8/api/profile_update");
    var request = http.MultipartRequest("POST", uri);
    // request.headers.addAll(
    //   await CustomHttpRequest().getHeaderWithToken(),
    // );
    request.fields['name'] = nameController.text.toString();
    request.fields['email'] = emailController.text.toString();
    request.fields['phone'] = phoneNumberController.text.toString();
    request.fields['address'] = addressController.text.toString();
    request.fields['gender']=user['gender'];
    request.fields['birthday']=user['birthday'].toString();
   request.fields['blood_group']="B+";
  
  print(nameController.text.toString());
  print(emailController.text.toString());
  print(phoneNumberController.text.toString());
  print(addressController.text.toString());
  print(user['gender']);
  print(user['birthday']);
  print("B+");
  
    // if (image != null) {
    //   var photo = await http.MultipartFile.fromPath('image', image!.path);
    //   print('processing');
    //   request.files.add(photo);
    // }

    // request.files.add(http.MultipartFile(
    //     'photo', image!.readAsBytes().asStream(), image!.lengthSync(),
    //     ));
       // filename: basename(image!.path)
    
    var response = await request.send();
    print("${response.statusCode}");

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var data = jsonDecode(responseString);

    if (response.statusCode == 201) {
      print("responseBody1 $responseData");
      print(data['message']);
      // showInToast(data['message']);
      // Provider.of<CategoryProvider>(context, listen: false).getCategory();
      Navigator.pop(context);
      print("${response.statusCode}");
    } else {
      print("responseBody1 $responseString");
      print(data['errors']['image'][0]);
      // showInToast(data["errors"]['image'][0]);
      // setState(() {
      //   onProgress = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DemoDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: userData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 260,
                          child: Column(
                            children: [
                              ClipPath(
                                clipper: CustomShape(),
                                child: Container(
                                  height: 200,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 140,
                          top: 95,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Center(
                                child: Image.network(
                              "${user['photo']}",
                              height: 97,
                              width: 97,
                            )),
                          ),
                        ),
                        Positioned(
                          left: 180,
                          top: 180,
                          child: Icon(
                            Icons.verified,
                            color: Colors.blue,
                          ),
                        ),
                        Positioned(
                          top: 200,
                          left: 100,
                          child: Padding(
                            //${user['name']}
                            padding: const EdgeInsets.only(left: 28, top: 5),
                            child: Center(
                                child: Text(
                              "${user['name']}",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        Positioned(
                          top: 225,
                          left: 140,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18, top: 3),
                            child: Center(
                                child: Text(
                              "Class ${user['class_name']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 20, top: 10),
                      child: Divider(
                        height: 5,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue.withOpacity(0.1),
                          ),
                          child: Center(
                              child: Text(
                            "Student Profile Image",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Upload File",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Preview",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: Text(
                              "Delete",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            strokeWidth: 2,
                            strokeCap: StrokeCap.butt,
                            color: Colors.black12,
                            child: InkWell(
                              onTap: () {
                                getImageformGallery();
                             
                              },
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: image==null ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 60),
                                      child: Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Colors.black26,
                                      ),
                                    ),
                                    Text(
                                      "Upload an Image",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ):Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(image!),
                          ),),
                          child: Icon(Icons.image),
                        ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Image.network(
                              '${user['photo']}',
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                          child: Text(
                        "Personal Info",
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue.withOpacity(0.1),
                          ),
                          child: Center(
                              child: Text(
                            "Basic Info",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Full Name",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "${user['name']}",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "${user['email']}",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Phone Number",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                          controller: phoneNumberController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "${user['phone']}",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Gender",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
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
                              width: 93,
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: (user['gender'] == "female")
                                        ? Icon(Icons.radio_button_checked,
                                            size: 15, color: Colors.blue)
                                        : Icon(Icons.radio_button_checked,
                                            size: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Female",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
                              width: 93,
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: (user['gender'] == "male")
                                        ? Icon(Icons.radio_button_checked,
                                            size: 15, color: Colors.blue)
                                        : Icon(Icons.radio_button_checked,
                                            size: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Male"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
                              width: 93,
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: (user['gender'] == "others")
                                        ? Icon(Icons.radio_button_checked,
                                            size: 15, color: Colors.blue)
                                        : Icon(Icons.radio_button_checked,
                                            size: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Others"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Bio",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                        height: 140,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                            hintMaxLines: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 40),
                      child: Text(
                        "Address",
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, bottom: 20, top: 5),
                      child: Container(
                        width: 170,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.withOpacity(0.1),
                        ),
                        child: Center(
                            child: Text(
                          "Your Address",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Location",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15, top: 10),
                      child: Container(
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
                          controller: addressController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "${user['address']}",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            hintMaxLines: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15),
                      child: Container(
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
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "London",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                            hintMaxLines: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15),
                      child: Container(
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
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "State",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                            hintMaxLines: 16,
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Address Line 1",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "45 Roker Terrace, Latheronwheel",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Address Line 2",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "Your Address",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Zip Code",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Container(
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
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 20),
                            hintText: "${user['address']}",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, bottom: 20, left: 120),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(fontSize: 14),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              saveChanges();
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                "Save Changes",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, bottom: 20, left: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Privacy",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Divider(
                                height: 5,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Who can see your profile photo?",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 15),
                              child: Container(
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
                                  keyboardType: TextInputType.emailAddress,
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 15, bottom: 15, left: 20),
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                    hintText: "Only Me",
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'images/privacy.PNG',
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, bottom: 20, left: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          height: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Delete Your Account",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Divider(
                                  height: 5,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                child: Text(
                                  "When you delete your account lose accessis Front account services and we permanentlly delete your personal data.You cante cancel the deletion for 14 days.",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor:
                                              Colors.black45),
                                      child: Checkbox(
                                          value: _rememberMe,
                                          checkColor: Colors.green,
                                          activeColor: Colors.white,
                                          onChanged: (value) {
                                            setState(() {});
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Text(
                                        "With your Pro account, you can disable\n ads across the site",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, bottom: 10, top: 10, left: 200),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "Delete",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
