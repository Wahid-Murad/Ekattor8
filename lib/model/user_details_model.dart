import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
    UserDetailsModel({
        this.id,
        this.userId,
        this.classId,
        this.sectionId,
        this.schoolId,
        this.departmentId,
        this.sessionId,
        this.createdAt,
        this.updatedAt,
        this.code,
        this.parentName,
        this.name,
        this.email,
        this.role,
        this.address,
        this.phone,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.photo,
        this.runningSession,
        this.className,
        this.sectionName,
    });

    int ? id;
    int ? userId;
    int ? classId;
    int ? sectionId;
    String ? schoolId;
    dynamic ? departmentId;
    String ? sessionId;
    DateTime ? createdAt;
    DateTime ? updatedAt;
    dynamic ? code;
    String ? parentName;
    String ? name;
    String ? email;
    String ? role;
    String ? address;
    String ? phone;
    int ? birthday;
    String ? gender;
    String ? bloodGroup;
    String ? photo;
    String ? runningSession;
    String ? className;
    String ? sectionName;

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        id: json["id"],
        userId: json["user_id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        schoolId: json["school_id"],
        departmentId: json["department_id"],
        sessionId: json["session_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        code: json["code"],
        parentName: json["parent_name"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        address: json["address"],
        phone: json["phone"],
        birthday: json["birthday"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        photo: json["photo"],
        runningSession: json["running_session"],
        className: json["class_name"],
        sectionName: json["section_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_id": classId,
        "section_id": sectionId,
        "school_id": schoolId,
        "department_id": departmentId,
        "session_id": sessionId,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "code": code,
        "parent_name": parentName,
        "name": name,
        "email": email,
        "role": role,
        "address": address,
        "phone": phone,
        "birthday": birthday,
        "gender": gender,
        "blood_group": bloodGroup,
        "photo": photo,
        "running_session": runningSession,
        "class_name": className,
        "section_name": sectionName,
    };
}
