// To parse this JSON data, do
//
//     final routineModel = routineModelFromJson(jsonString);

import 'dart:convert';

RoutineModel routineModelFromJson(String str) => RoutineModel.fromJson(json.decode(str));

String routineModelToJson(RoutineModel data) => json.encode(data.toJson());

class RoutineModel {
    RoutineModel({
        this.classId,
        this.className,
        this.sectionId,
        this.sectionName,
        this.schoolId,
        this.sessionId,
        this.routines,
    });

    int ? classId;
    String ? className;
    int ? sectionId;
    String ? sectionName;
    String ? schoolId;
    String ? sessionId;
    List<Routine> ? routines;

    factory RoutineModel.fromJson(Map<String, dynamic> json) => RoutineModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        routines: List<Routine>.from(json["routines"].map((x) => Routine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "routines": List<dynamic>.from(routines!.map((x) => x.toJson())),
    };
}

class Routine {
    Routine({
        this.id,
        this.subjectId,
        this.subjectName,
        this.startingTime,
        this.endingTime,
        this.day,
        this.teacherId,
        this.teacherName,
    });

    int ? id;
    String ? subjectId;
    String ? subjectName;
    String ? startingTime;
    String ? endingTime;
    String ? day;
    String ? teacherId;
    String ? teacherName;

    factory Routine.fromJson(Map<String, dynamic> json) => Routine(
        id: json["id"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        startingTime: json["starting_time"],
        endingTime: json["ending_time"],
        day: json["day"],
        teacherId: json["teacher_id"],
        teacherName: json["teacher_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subject_id": subjectId,
        "subject_name": subjectName,
        "starting_time": startingTime,
        "ending_time": endingTime,
        "day": day,
        "teacher_id": teacherId,
        "teacher_name": teacherName,
    };
}
