import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
    BookModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.books,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<Book> books;

    factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
    };
}

class Book {
    Book({
        required this.id,
        required this.name,
        required this.author,
        required this.copies,
        required this.availableCopies,
    });

    int id;
    String name;
    String author;
    String copies;
    int availableCopies;

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        name: json["name"],
        author: json["author"],
        copies: json["copies"],
        availableCopies: json["available_copies"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "author": author,
        "copies": copies,
        "available_copies": availableCopies,
    };
}
