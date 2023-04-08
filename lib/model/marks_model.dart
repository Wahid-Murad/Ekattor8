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
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<ExamMark> examMarks;

    factory MarksModel.fromJson(Map<String, dynamic> json) => MarksModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        examMarks: List<ExamMark>.from(json["exam_marks"].map((x) => ExamMark.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "exam_marks": List<dynamic>.from(examMarks.map((x) => x.toJson())),
    };
}

class ExamMark {
    ExamMark({
        required this.id,
        required this.classId,
        required this.sectionId,
        required this.examCategoryId,
        required this.bangla,
        required this.english,
        required this.drawing,
        required this.mathematics,
        required this.comment,
    });

    int id;
    String classId;
    String sectionId;
    String examCategoryId;
    String bangla;
    String english;
    String drawing;
    String mathematics;
    String comment;

    factory ExamMark.fromJson(Map<String, dynamic> json) => ExamMark(
        id: json["id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        examCategoryId: json["exam_category_id"],
        bangla: json["Bangla"],
        english: json["English"],
        drawing: json["Drawing"],
        mathematics: json["Mathematics"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "section_id": sectionId,
        "exam_category_id": examCategoryId,
        "Bangla": bangla,
        "English": english,
        "Drawing": drawing,
        "Mathematics": mathematics,
        "comment": comment,
    };
}
