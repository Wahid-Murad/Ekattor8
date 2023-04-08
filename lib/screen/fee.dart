import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/fee_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class FeePage extends StatefulWidget {
  const FeePage({super.key});

  @override
  State<FeePage> createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //  WebViewController webViewController = WebViewController();
  var fee;
  String? selectedValue;
  SharedPreferences? sharedPreferences;
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();

  List<FeeModel> feeData = [];
  List<Invoice> feeDataDemo = [];

  fetchFee() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/fee_list";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      fee = jsonDecode(response.body);
      FeeModel feeModel = FeeModel(
        classId: fee['class_id'],
        className: fee['class_name'],
        sectionId: fee['section_id'],
        sectionName: fee['section_name'],
        schoolId: fee['school_id'],
        sessionId: fee['session_id'],
        invoices: [],
        // examMarks: [],
      );
      setState(() {
        feeData.add(feeModel);
      });

      for (var data in fee["invoices"]) {
        if (selectedValue == null) {
          Invoice feedemo = Invoice(
            id: data["id"],
            title: data["title"],
            totalAmount: data["total_amount"],
            paymentMethod: data["payment_method"],
            paidAmount: data["paid_amount"],
            status: data["status"],
            timestamp: data["timestamp"],
          );

          setState(() {
            feeDataDemo.add(feedemo);
          });
        }

        if (data["status"] == selectedValue) {
          Invoice feedemo = Invoice(
            id: data["id"],
            title: data["title"],
            totalAmount: data["total_amount"],
            paymentMethod: data["payment_method"],
            paidAmount: data["paid_amount"],
            status: data["status"],
            timestamp: data["timestamp"],
          );
          setState(() {
            feeDataDemo.add(feedemo);
          });
        }
      }
    }
  }

  @override
  void initState() {
    fetchFee();
    super.initState();
  }

  static var status = [
    'unpaid',
    'pending',
  ];

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 01, 01),
      lastDate: DateTime(2035, 12, 31),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  void _showDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 01, 01),
      lastDate: DateTime(2035, 12, 31),
    ).then((value) {
      setState(() {
        _dateTime2 = value!;
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
                            'Fee',
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
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_dateTime.toString().split(" ")[0]),
                  Text(_dateTime2.toString().split(" ")[0]),
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
                    padding: const EdgeInsets.only( left: 20,right: 20, top: 5),
                    child: InkWell(
                      onTap: _showDatePicker,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0XFFE7F5FE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          "Start Day",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF00A2FE)),
                        )),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only( top: 5,right: 20),
                    child: InkWell(
                      onTap: _showDatePicker2,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0XFFE7F5FE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          "End Day",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF00A2FE)),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20,right: 20),
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
                                  "Select Status",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF0BA6FE),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        items: status
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
                            feeDataDemo.clear();
                            Colors.blue;
                          });
                          fetchFee();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                        ),
                        iconSize: 16,
                        iconEnabledColor: Color(0XFF0DA6FD),
                        iconDisabledColor: Color(0XFF0DA6FD),
                        buttonHeight: 40,
                        buttonWidth: 140,
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
                        dropdownMaxHeight: 140,
                        dropdownWidth: 140,
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
                  padding: const EdgeInsets.only(top: 10,right: 20),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.62,
                child: ListView.builder(
                  itemCount: feeDataDemo.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Invoice Title",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${feeDataDemo[index].title}",
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
                                      "Total Amount",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${feeDataDemo[index].totalAmount}",
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
                                      "Paid Amount",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${feeDataDemo[index].paidAmount}",
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
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
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
                                    "${feeDataDemo[index].status}" == "unpaid"
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.21,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            decoration: BoxDecoration(
                                              color: Color(0XFFFEE4EB),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${feeDataDemo[index].status}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0XFFF2547B)),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.21,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            decoration: BoxDecoration(
                                              color: Color(0XFFDAFEEB),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${feeDataDemo[index].status}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0XFF3DC57B)),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              // Text(
                              //       "${feeDataDemo[index].status}",
                              //       style: GoogleFonts.poppins(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w500,
                              //           color: Color(0XFF7C7F8D)),
                              //     ),

                          InkWell(
                            // onTap: _showWebView,
                            onTap: () {
                              
                            },
                            child: Container(
                                                  width: 80,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                            color: Color(0XFFE7F5FE),
                            borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Center(
                              child: Text(
                            "Invoice",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF00A2FE)),
                                                  )),
                                                ),
                          ),
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
