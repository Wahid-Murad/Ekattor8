import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/model/syllabus_model.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_file_downloader/download_callbacks.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({super.key});

  @override
  State<SyllabusPage> createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  var syllabus;
  String? selectedValue;
  SharedPreferences? sharedPreferences;

  List<SyllabusModel> syllabusData = [];
  List<Syllabuse> syllabusDataDemo = [];

  fetchSyllabus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/syllabus_list";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      syllabus = jsonDecode(response.body);
      SyllabusModel syllabusModel = SyllabusModel(
        classId: syllabus['class_id'],
        className: syllabus['class_name'],
        sectionId: syllabus['section_id'],
        sectionName: syllabus['section_name'],
        schoolId: syllabus['school_id'],
        sessionId: syllabus['session_id'],
        syllabuses: [],
      );
      setState(() {
        syllabusData.add(syllabusModel);
      });

      for (var data in syllabus["syllabuses"]) {
        if (selectedValue == null) {
          Syllabuse syllabusdemo = Syllabuse(
            id: data["id"],
            title: data['title'],
            subjectId: data['subject_id'],
            subjectName: data['subject_name'],
            fileUrl: data['file_url'],
          );
          setState(() {
            syllabusDataDemo.add(syllabusdemo);
          });
        }

        if (data["subject_name"] == selectedValue) {
          Syllabuse syllabusdemo = Syllabuse(
            id: data["id"],
            title: data['title'],
            subjectId: data['subject_id'],
            subjectName: data['subject_name'],
            fileUrl: data['file_url'],
          );
          setState(() {
            syllabusDataDemo.add(syllabusdemo);
          });
        }
      }
    }
  }

  @override
  void initState() {
    fetchSyllabus();
    super.initState();
  }

  static var subject = [
    'English',
    'Mathematics',
    'Bangla',
    'Drawing',
    // 'Physics',
    // 'GK',
    // 'Chemistry',
  ];

  double? progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TopBar(
                title: "Syllabus",
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Subject",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF26B0FE),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    items: subject
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Center(
                                child: Text(
                                  item.replaceFirst(
                                      item[0], item[0].toUpperCase()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    style: TextStyle(
                        fontSize: 20, color: Colors.white), //white color
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        syllabusDataDemo.clear();
                        Colors.blue;
                      });
      
                      fetchSyllabus();
                    },
                    icon: Align(
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                    ),
                    iconSize: 20,
                    iconEnabledColor: Color(0XFF0DA6FD),
                    iconDisabledColor: Color(0XFF0DA6FD),
                    buttonHeight: 40,
                    buttonWidth: 120,
                    buttonPadding: const EdgeInsets.only(left: 6, right: 6),
                    buttonDecoration: BoxDecoration(
                      color: Color(0XFFE7F5FE),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 160,
                    dropdownWidth: 120,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(10),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.63,
                width: MediaQuery.of(context).size.width * 0.90,
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              "Title",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              "Syllabus",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: MediaQuery.of(context).size.height * syllabusDataDemo.length*0.082,
                          child: ListView.builder(
                            itemCount: syllabusDataDemo.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    // height: MediaQuery.of(context).size.height*0.032,
                                    Row(
                                      children: [
                                        Text(
                                          "${syllabusDataDemo[index].title}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,color: Color(0XFF7C7F8D)),
                                        ),
                                        Spacer(), // progress != null ? const CircularProgressIndicator():
      
                                        InkWell(
                                          onTap: () {
                                            FileDownloader.downloadFile(
                                                url: syllabusDataDemo[index]
                                                    .fileUrl);
                                            onProgress:
                                            (name, progress) {
                                              setState(() {
                                                progress = progress;
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Downloading $progress%");
                                              });
                                            };
                                            onDownloadCompleted:
                                            (value) {
                                              print('path  $value ');
                                              setState(() {
                                                progress = null;
                                                Fluttertoast.showToast(
                                                    msg: "Download Completed");
                                              });
                                            };
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            decoration: BoxDecoration(
                                              color: Color(0XFF00A3FF),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              Icons.save_alt_outlined,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
      
                                    const Divider(
                                      height: 23,
                                      thickness: 0.8,
                                    ),
                                  ],
                                ),
                              );
                            },
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
      ),
    );
  }
}
