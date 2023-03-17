import 'dart:convert';

TeachersModel teachersModelFromJson(String str) => TeachersModel.fromJson(json.decode(str));

String teachersModelToJson(TeachersModel data) => json.encode(data.toJson());

class TeachersModel {
    TeachersModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.teachers,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<Teacher> teachers;

    factory TeachersModel.fromJson(Map<String, dynamic> json) => TeachersModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        teachers: List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "teachers": List<dynamic>.from(teachers.map((x) => x.toJson())),
    };
}

class Teacher {
    Teacher({
        required this.id,
        required this.name,
        required this.departmentId,
        required this.schoolId,
        required this.departmentName,
        this.designation,
    });

    int id;
    String name;
    String departmentId;
    String schoolId;
    String departmentName;
    String? designation;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        name: json["name"],
        departmentId: json["department_id"],
        schoolId: json["school_id"],
        departmentName: json["department_name"],
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department_id": departmentId,
        "school_id": schoolId,
        "department_name": departmentName,
        "designation": designation,
    };
}
