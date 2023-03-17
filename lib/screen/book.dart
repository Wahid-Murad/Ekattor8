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
        // subjects: [],
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
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TopBar(
              title: "Book",
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            child: ListView.builder(
              itemCount: bookDataDemo.length,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: Row(
                            children: [
                              Text(
                                "Book Name",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Text(
                                "Available Copies",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            children: [
                              Text(
                                  "${bookDataDemo[index].name}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Text(
                                  "${bookDataDemo[index].availableCopies}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 13, fontWeight: FontWeight.w300),
                                ),
                            ],
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: Align(
                            alignment: Alignment.bottomLeft,
                             child: Text(
                                      "${bookDataDemo[index].author}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, fontWeight: FontWeight.w300),
                                    ),
                           ),
                         ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
