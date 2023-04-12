// To parse this JSON data, do
//
//     final examsModel = examsModelFromJson(jsonString);

import 'dart:convert';

ExamsModel examsModelFromJson(String str) => ExamsModel.fromJson(json.decode(str));

String examsModelToJson(ExamsModel data) => json.encode(data.toJson());

class ExamsModel {
    ExamsModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.exams,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<Exam> exams;

    factory ExamsModel.fromJson(Map<String, dynamic> json) => ExamsModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        exams: List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "exams": List<dynamic>.from(exams.map((x) => x.toJson())),
    };
}

class Exam {
    Exam({
        required this.id,
        required this.name,
        required this.examType,
        required this.subjectId,
        required this.subjectName,
        required this.startingTime,
        required this.endingTime,
        required this.totalMarks,
        required this.status,
    });

    int id;
    String name;
    String examType;
    String subjectId;
    String subjectName;
    String startingTime;
    String endingTime;
    String totalMarks;
    String status;

    factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        name: json["name"],
        examType: json["exam_type"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        startingTime: json["starting_time"],
        endingTime: json["ending_time"],
        totalMarks: json["total_marks"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "exam_type": examType,
        "subject_id": subjectId,
        "subject_name": subjectName,
        "starting_time": startingTime,
        "ending_time": endingTime,
        "total_marks": totalMarks,
        "status": status,
    };
}
