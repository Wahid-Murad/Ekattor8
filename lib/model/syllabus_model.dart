import 'dart:convert';

SyllabusModel syllabusModelFromJson(String str) => SyllabusModel.fromJson(json.decode(str));

String syllabusModelToJson(SyllabusModel data) => json.encode(data.toJson());

class SyllabusModel {
    SyllabusModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.syllabuses,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<Syllabuse> syllabuses;

    factory SyllabusModel.fromJson(Map<String, dynamic> json) => SyllabusModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        syllabuses: List<Syllabuse>.from(json["syllabuses"].map((x) => Syllabuse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "syllabuses": List<dynamic>.from(syllabuses.map((x) => x.toJson())),
    };
}

class Syllabuse {
    Syllabuse({
        required this.id,
        required this.title,
        required this.subjectId,
        required this.subjectName,
        required this.fileUrl,
    });

    int id;
    String title;
    String subjectId;
    String subjectName;
    String fileUrl;

    factory Syllabuse.fromJson(Map<String, dynamic> json) => Syllabuse(
        id: json["id"],
        title: json["title"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        fileUrl: json["file_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subject_id": subjectId,
        "subject_name": subjectName,
        "file_url": fileUrl,
    };
}
