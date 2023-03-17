import 'dart:convert';

SubjectModel subjectModelFromJson(String str) => SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
    SubjectModel({
        required this.classId,
        required this.className,
        required this.schoolId,
        required this.sessionId,
        required this.subjects,
    });

    int classId;
    String className;
    String schoolId;
    String sessionId;
    List<Subject> subjects;

    factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        classId: json["class_id"],
        className: json["class_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "school_id": schoolId,
        "session_id": sessionId,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    };
}

class Subject {
    Subject({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
