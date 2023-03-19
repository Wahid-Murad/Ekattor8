import 'dart:convert';

import 'package:ekattor_8/model/book_model.dart';
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
         //filteredBook=bookDataDemo;
        });
      }
      // for (var info in book2["books"]) {//extra added
      //   Book bookdemo2 = Book(
      //     id: info["id"],
      //     name: info["name"],
      //     author: info["author"],
      //     copies: info["copies"],
      //     availableCopies: info["available_copies"],
      //   );
      //   setState(() {
      //     display_list.add(bookdemo2);
      //   });
      // }

    }
  }

  @override
  void initState() {
    fetchBook();
    setState(() {
    filteredBook=bookDataDemo;
    });
    super.initState();
  }

  // List<Map<String, dynamic>> foundBook = []; //extra added
  // List<Map<String, dynamic>> testBook = [];//extra added
  // void runFilter(String enteredKeyword){//extra added
  // List<Book> results=[];
  // if(enteredKeyword.isEmpty){
  //   results=bookDataDemo;
  // }
  // else{
  //   results=bookDataDemo.where((bookname) => bookname.name.toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  // }
  // setState(() {
  //   foundBook=results.cast<Map<String, dynamic>>();
  // });
  // }

  //  = [];

  // void copyList() {
  //   display_list.addAll(bookDataDemo);
  // }
  // List<Book> display_list = List.from(bookDataDemo);



  // void updateList(String value) {
  //   //This is the function that filter our list
  //   setState(() {
  //     bookDataDemo.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
  //   });
  // }

  void filterBook(value){
    setState(() {
       filteredBook=bookDataDemo.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TopBar(
                title: "Book",
              ),
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
                  // controller: searchController,
                  // onChanged: (value) => updateList(value),
                  // onChanged: (value) => runFilter(value),//extra added
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    //filled: true,
                    //fillColor: Color(0XFFB7BAC2),
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.72,
                child: filteredBook.length >0 ? ListView.builder(
                  itemCount: filteredBook.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                //"${bookDataDemo[index].name}",
                                children: [
                                  Text(
                                    "${filteredBook[index].name}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${filteredBook[index].availableCopies}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ):Image.asset('images/nodata.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
