// To parse this JSON data, do
//
//     final issueBookModel = issueBookModelFromJson(jsonString);

import 'dart:convert';

IssueBookModel issueBookModelFromJson(String str) => IssueBookModel.fromJson(json.decode(str));

String issueBookModelToJson(IssueBookModel data) => json.encode(data.toJson());

class IssueBookModel {
    IssueBookModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.issuedBooks,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<IssuedBook> issuedBooks;

    factory IssueBookModel.fromJson(Map<String, dynamic> json) => IssueBookModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        issuedBooks: List<IssuedBook>.from(json["issued_books"].map((x) => IssuedBook.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "issued_books": List<dynamic>.from(issuedBooks.map((x) => x.toJson())),
    };
}

class IssuedBook {
    IssuedBook({
        required this.id,
        required this.bookId,
        required this.bookName,
        required this.author,
        required this.issueDate,
        required this.status,
    });

    int id;
    String bookId;
    String bookName;
    String author;
    String issueDate;
    String status;

    factory IssuedBook.fromJson(Map<String, dynamic> json) => IssuedBook(
        id: json["id"],
        bookId: json["book_id"],
        bookName: json["book_name"],
        author: json["author"],
        issueDate: json["issue_date"],
        status: json["status"],
    );

  get d12 => null;

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "book_name": bookName,
        "author": author,
        "issue_date": issueDate,
        "status": status,
    };
}
