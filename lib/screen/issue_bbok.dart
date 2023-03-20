import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/model/book_issue_model.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class IssueBookPage extends StatefulWidget {
  const IssueBookPage({super.key});

  @override
  State<IssueBookPage> createState() => _IssueBookPageState();
}

class _IssueBookPageState extends State<IssueBookPage> {

  String ? selectedValue;
   var ts;


  var issuebook;
  SharedPreferences ? sharedPreferences;

  List<IssueBookModel> issuebookData = [];
  List<IssuedBook> issuebookDataDemo = [];

  fetchIssueBook() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/book_issue_list";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      issuebook = jsonDecode(response.body);
      IssueBookModel issuebookModel = IssueBookModel(
        classId: issuebook['class_id'],
        className: issuebook['class_name'],
        sectionId: issuebook['section_id'],
        sectionName: issuebook['section_name'],
        schoolId: issuebook['school_id'],
        sessionId: issuebook['session_id'],
        issuedBooks: [],
      );
      setState(() {
        issuebookData.add(issuebookModel);
      });

      for (var data in issuebook["issued_books"]) {
        IssuedBook issuebookdemo = IssuedBook(
         id: data['id'],
         bookId: data['book_id'],
         bookName: data['book_name'],
         author: data['author'],
         issueDate: data['issue_date'],
         status: data['status'],
         );
        setState(() {
          issuebookDataDemo.add(issuebookdemo);
        });
      }
    }
  }

  @override
  void initState() {
    fetchIssueBook();
    super.initState();
  }

                   



  static var issueDate = [
    '11/20/22-12/20/22',
    '12/20/22-01/20/23',
    '01/20/23-02/20/23',
    '02/20/23-03/20/23',
    '03/20/23-04/20/23',
    '04/20/23-05/20/23',
    '05/20/23-06/20/23',
    '06/20/23-07/20/23',
    '07/20/23-08/20/23',
    '08/20/23-09/20/23',
    '09/20/23-10/20/23',
    '10/20/23-11/20/23',
    '11/20/23-12/20/23',
    '12/20/23-01/20/24',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TopBar(
              title: "Book Issue",
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
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
                                "Issue Date",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF0BA6FE),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      items: issueDate
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
                          // teacherDataDemo.clear();
                          Colors.blue;
                        });

                        //  fetchTeacher();
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
                      buttonWidth: 240,
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
                      dropdownMaxHeight: 220,
                      dropdownWidth: 220,
                      dropdownPadding: null,
                      // selectedItemHighlightColor: Colors.white,//
                      //  focusColor: Colors.white,
                      // itemSplashColor: Colors.white,
                      // itemHighlightColor: Colors.white,
                      // buttonSplashColor: Colors.white,
                      // buttonHighlightColor: Colors.white,
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

              Spacer(),

              Padding(
                padding: const EdgeInsets.only(top: 10,right: 15),
                child: InkWell(
                    onTap: () {
                      
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.21,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0XFF00A2FE),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text("Filter",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0XFFFAFDFE)),)),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.70,
              child: ListView.builder(
                itemCount: issuebookDataDemo.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.225,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Book Name",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${issuebookDataDemo[index].bookName}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,color: Color(0XFF7C7F8D)),
                                  ),
                               
                                ],
                              ),
                            ),
                               
                               Divider(
                                      height: 23,
                                      thickness: 0.8,
                                    ),
                                    
                                    Padding(
                              padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Issue Date",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                 // ts = issuebookDataDemo[index].issueDate;
                              // DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(issuebookDataDemo[index].issueDate);
                          // String datetime = tsdate.year.toString() + "/" + tsdate.month.toString() + "/" + tsdate.day.toString();
                                  Text(
                                    "${issuebookDataDemo[index].issueDate}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                       fontWeight: FontWeight.w500,color: Color(0XFF7C7F8D)),
                                  ),
                               
                                ],
                              ),
                            ),

                                 Divider(
                                      height: 23,
                                      thickness: 0.8,
                                    ),
                                    

                               Padding(
                              padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                              child: Row(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Center(
                                        child: Text(
                                          "Status",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  // Text(
                                  //   "The Chrismas Pig",
                                  //   style: GoogleFonts.poppins(
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.w400),
                                  // ),

                                  Container(
                                    width: MediaQuery.of(context).size.width*0.21,
                                    height: MediaQuery.of(context).size.height*0.045,
                                    decoration: BoxDecoration(
                                      color: Color(0XFFFDF4D3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text("${issuebookDataDemo[index].status}",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w700,color: Color(0XFFFED546)))),
                                  ),
                                ],
                              ),
                            ),
                               

                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10, right: 10),
                            //   child: Row(
                            //     //"${bookDataDemo[index].name}",
                            //     children: [
                            //       Text(
                            //         //${filteredBook[index].name}
                            //         "Abc",
                            //         style: GoogleFonts.poppins(
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //       Spacer(),
                            //       Text(
                            //         //${filteredBook[index].availableCopies}
                            //         "123",
                            //         style: GoogleFonts.poppins(
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w300),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10),
                            //   child: Align(
                            //     alignment: Alignment.bottomLeft,
                            //     child: Text(
                            //       //${filteredBook[index].author}
                            //       "a1",
                            //       style: GoogleFonts.poppins(
                            //           fontSize: 12, fontWeight: FontWeight.w300),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}