// To parse this JSON data, do
//
//     final feeModel = feeModelFromJson(jsonString);

import 'dart:convert';

FeeModel feeModelFromJson(String str) => FeeModel.fromJson(json.decode(str));

String feeModelToJson(FeeModel data) => json.encode(data.toJson());

class FeeModel {
    FeeModel({
        required this.classId,
        required this.className,
        required this.sectionId,
        required this.sectionName,
        required this.schoolId,
        required this.sessionId,
        required this.invoices,
    });

    int classId;
    String className;
    int sectionId;
    String sectionName;
    String schoolId;
    String sessionId;
    List<Invoice> invoices;

    factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
        classId: json["class_id"],
        className: json["class_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        schoolId: json["school_id"],
        sessionId: json["session_id"],
        invoices: List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "section_id": sectionId,
        "section_name": sectionName,
        "school_id": schoolId,
        "session_id": sessionId,
        "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
    };
}

class Invoice {
    Invoice({
        required this.id,
        required this.title,
        required this.totalAmount,
        required this.paymentMethod,
        required this.paidAmount,
        required this.status,
        required this.timestamp,
    });

    int id;
    String title;
    String totalAmount;
    String paymentMethod;
    String paidAmount;
    String status;
    String timestamp;

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        title: json["title"],
        totalAmount: json["total_amount"],
        paymentMethod: json["payment_method"],
        paidAmount: json["paid_amount"],
        status: json["status"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "total_amount": totalAmount,
        "payment_method": paymentMethod,
        "paid_amount": paidAmount,
        "status": status,
        "timestamp": timestamp,
    };
}
