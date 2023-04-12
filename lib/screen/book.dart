import 'dart:convert';

import 'package:ekattor_8/consts/drawer.dart';
import 'package:ekattor_8/model/book_model.dart';
import 'package:ekattor_8/topbar/my_custom_clipper.dart';
import 'package:ekattor_8/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var book;
  SharedPreferences? sharedPreferences;

  List<BookModel> bookData = [];
  List<Book> bookDataDemo = [];
  List<Book> filteredBook = [];
  bool isSearching = false;

  // TextEditingController searchController = TextEditingController();

  fetchBook() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic token = sharedPreferences!.getString("access_token");

    print(token);

    var url = "https://demo.creativeitem.com/test/Ekattor8/api/book_list";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      print(response.body);
      book = jsonDecode(response.body);
      BookModel bookModel = BookModel(
        classId: book['class_id'],
        className: book['class_name'],
        sectionId: book['section_id'],
        sectionName: book['section_name'],
        schoolId: book['school_id'],
        sessionId: book['session_id'],
        books: [],
      );
      setState(() {
        bookData.add(bookModel);
      });

      for (var data in book["books"]) {
        Book bookdemo = Book(
          id: data["id"],
          name: data["name"],
          author: data["author"],
          copies: data["copies"],
          availableCopies: data["available_copies"],
        );
        setState(() {
          bookDataDemo.add(bookdemo);
        });
      }
    }
  }

  @override
  void initState() {
    fetchBook();
    setState(() {
      filteredBook = bookDataDemo;
    });
    super.initState();
  }

  void filterBook(value) {
    setState(() {
      filteredBook = bookDataDemo
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
          
      // filteredBook = bookDataDemo
      //     .where((element) =>
      //         element.author.toLowerCase().contains(value.toLowerCase()))
      //     .toList();
          
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
                            'Book',
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
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Color(0XFFF4F7F9),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 0.5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    filterBook(value);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 15,
                      color: Color(0XFFB7BAC2),
                    ),
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Color(0XFFB7BAC2),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.70,
                child: filteredBook.length > 0
                    ? ListView.builder(
                        itemCount: filteredBook.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        left: 10,
                                        right: 10,
                                      ),
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
                                            "Available Copies",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 15,
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        //"${bookDataDemo[index].name}",
                                        children: [
                                          Text(
                                            "${filteredBook[index].name}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF11152C)),
                                          ),
                                          Spacer(),
                                          Text(
                                            "${filteredBook[index].availableCopies}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF7C7F8D)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "${filteredBook[index].author}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF7C7F8D)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset('images/nodata.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
