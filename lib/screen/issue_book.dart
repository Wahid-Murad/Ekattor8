import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/book_issue_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class IssueBookPage extends StatefulWidget {
  const IssueBookPage({super.key});

  @override
  State<IssueBookPage> createState() => _IssueBookPageState();
}

class _IssueBookPageState extends State<IssueBookPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var issuebook;
  String? selectedValue;
  var issuedate;
  var dt;
  var d12;
  DateTime _dateTime=DateTime.now();
  DateTime _dateTime2=DateTime.now();
  SharedPreferences? sharedPreferences;

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
          issuedate = int.parse( data['issue_date']);
          dt = DateTime.fromMillisecondsSinceEpoch(issuedate * 1000);
          d12 = DateFormat('d MMM,yyyy  h:mm a').format(dt);
        IssuedBook issuebookdemo = IssuedBook(
          id: data['id'],
          bookId: data['book_id'],
          bookName: data['book_name'],
          author: data['author'],
          issueDate: d12,
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



  void _showDatePicker(){
    showDatePicker(
      context: context,
       initialDate: DateTime.now(), 
       firstDate: DateTime(2020,01,01),
        lastDate: DateTime(2035,12,31),
        ).then((value){
          setState(() {
            _dateTime=value!;
          });
        });
  }

  void _showDatePicker2(){
    showDatePicker(
      context: context,
       initialDate: DateTime.now(), 
       firstDate: DateTime(2020,01,01),
        lastDate: DateTime(2035,12,31),
        ).then((value){
          setState(() {
            _dateTime2=value!;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DemoDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                color: Color(0XFF00A3FF),
                height: MediaQuery.of(context).size.height * 0.22,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 30),
                      child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 18,
                            ),
                          )),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 30),
                          child: Text(
                            'Issue Book',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              clipper: MyCustomClipper(),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Start Day",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),),
                  Text("End Day",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),),//_dateTime2.toString().split(" ")[0]
                ],
              ),
            ),
          
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: InkWell(
                      onTap: _showDatePicker,
                      child: Container(
                        width: 90,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0XFFE7F5FE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          DateFormat('d MMM,yyyy').format(_dateTime),
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF00A2FE)),
                        )),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 20),
                    child: InkWell(
                      onTap: _showDatePicker2,
                      child: Container(
                        width: 90,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0XFFE7F5FE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          DateFormat('d MMM,yyyy').format(_dateTime2),
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF00A2FE)),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: InkWell(
                onTap: () {

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0XFF00A2FE),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      "Filter",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFFAFDFE)),
                    )),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.61,
                child: ListView.builder(
                  itemCount: issuebookDataDemo.length,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.215,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
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
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF7C7F8D)),
                                    ),
                                  ],
                                ),
                              ),
      
                              Divider(
                                height: 23,
                                thickness: 0.8,
                              ),
      
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
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
      
                                    //   var date = DateTime.fromMicrosecondsSinceEpoch(issuebookDataDemo[index].issueDate);
                                    // String datetime = tsdate.year.toString() + "/" + tsdate.month.toString() + "/" + tsdate.day.toString();
                                    // issuedate=int.parse(issuebookDataDemo[index].issueDate);
        
      
                                    Text(
                                      "${issuebookDataDemo[index].issueDate}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF7C7F8D)),
                                    ),
                                  ],
                                ),
                              ),
      
                              Divider(
                                height: 23,
                                thickness: 0.8,
                              ),
      
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
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
                              issuebookDataDemo[index].status=="pending" ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.21,
                                      height: MediaQuery.of(context).size.height *
                                          0.045,
                                      decoration: BoxDecoration(
                                        color: Color(0XFFFDF4D3),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Text(
                                              "${issuebookDataDemo[index].status}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0XFFFED546)))),
                                    ):Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.21,
                                      height: MediaQuery.of(context).size.height *
                                          0.045,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 214, 247, 214),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Text(
                                              "${issuebookDataDemo[index].status}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(255, 57, 175, 57)))),
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
      ),
    );
  }
}
