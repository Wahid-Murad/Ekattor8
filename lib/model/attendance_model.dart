import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
    AttendanceModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.attedances,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<Attendance> attedances;

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        attedances: List<Attendance>.from(json["attedances"].map((x) => Attendance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "attedances": List<dynamic>.from(attedances.map((x) => x.toJson())),
    };
}

class Attendance {
    Attendance({
        required this.id,
        required this.status,
        required this.timestamp,
    });

    int id;
    String status;
    String timestamp;

    factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        status: json["status"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "timestamp": timestamp,
    };
}
