// To parse this JSON data, do
//
//     final marksModel = marksModelFromJson(jsonString);

import 'dart:convert';

MarksModel marksModelFromJson(String str) => MarksModel.fromJson(json.decode(str));

String marksModelToJson(MarksModel data) => json.encode(data.toJson());

class MarksModel {
    MarksModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.examMarks,
        required this.examCategories,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<ExamMark> examMarks;
    List<ExamCategory> examCategories;

    factory MarksModel.fromJson(Map<String, dynamic> json) => MarksModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        examMarks: List<ExamMark>.from(json["exam_marks"].map((x) => ExamMark.fromJson(x))),
        examCategories: List<ExamCategory>.from(json["exam_categories"].map((x) => ExamCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "exam_marks": List<dynamic>.from(examMarks.map((x) => x.toJson())),
        "exam_categories": List<dynamic>.from(examCategories.map((x) => x.toJson())),
    };
}

class ExamCategory {
    ExamCategory({
        required this.examCategoryId,
        required this.examCategoryName,
    });

    int examCategoryId;
    String examCategoryName;

    factory ExamCategory.fromJson(Map<String, dynamic> json) => ExamCategory(
        examCategoryId: json["exam_category_id"],
        examCategoryName: json["exam_category_name"],
    );

    Map<String, dynamic> toJson() => {
        "exam_category_id": examCategoryId,
        "exam_category_name": examCategoryName,
    };
}

class ExamMark {
    ExamMark({
        required this.examId,
        required this.examCategoryId,
        required this.subjects,
        required this.comment,
    });

    int examId;
    String examCategoryId;
    List<Subject> subjects;
    String comment;

    factory ExamMark.fromJson(Map<String, dynamic> json) => ExamMark(
        examId: json["exam_id"],
        examCategoryId: json["exam_category_id"],
        subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "exam_id": examId,
        "exam_category_id": examCategoryId,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "comment": comment,
    };
}

class Subject {
    Subject({
        required this.subjectId,
        required this.subjectName,
        required this.marks,
    });

    int subjectId;
    String subjectName;
    String marks;

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        marks: json["marks"],
    );

    Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "subject_name": subjectName,
        "marks": marks,
    };
}
