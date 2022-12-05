// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.message,
        this.token,
        this.user,
    });

    String ? message;
    String ? token;
    User ? user;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    // Map<String, dynamic> toJson() => {
    //     "message": message,
    //     "token": token,
    //     "user": user!.toJson(),
    // };
}

class User {
    User({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.parentId,
        this.schoolId,
        this.code,
        this.userInformation,
        this.departmentId,
        this.designation,
        this.createdAt,
        this.updatedAt,
    });

    int ? id;
    String ? name;
    String ? email;
    dynamic ? emailVerifiedAt;
    String ? roleId;
    String ? parentId;
    String ? schoolId;
    dynamic ? code;
    String ? userInformation;
    dynamic ? departmentId;
    dynamic ? designation;
    DateTime ? createdAt;
    DateTime ? updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        parentId: json["parent_id"],
        schoolId: json["school_id"],
        code: json["code"],
        userInformation: json["user_information"],
        departmentId: json["department_id"],
        designation: json["designation"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "name": name,
    //     "email": email,
    //     "email_verified_at": emailVerifiedAt,
    //     "role_id": roleId,
    //     "parent_id": parentId,
    //     "school_id": schoolId,
    //     "code": code,
    //     "user_information": userInformation,
    //     "department_id": departmentId,
    //     "designation": designation,
    //     "created_at": createdAt!.toIso8601String(),
    //     "updated_at": updatedAt!.toIso8601String(),
    // };
}
