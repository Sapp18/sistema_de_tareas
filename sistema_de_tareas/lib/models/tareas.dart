// To parse this JSON data, do
//
//     final tareas = tareasFromJson(jsonString);

import 'dart:convert';

List<Tareas> tareasFromJson(String str) => List<Tareas>.from(json.decode(str).map((x) => Tareas.fromJson(x)));

String tareasToJson(List<Tareas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tareas {
    Tareas({
        this.id,
        required this.title,
        required this.isCompleted,
        this.dueDate,
        this.comments,
        this.description,
        this.tags,
        this.token,
    });

    int? id;
    String title;
    int isCompleted;
    dynamic dueDate;
    String? comments;
    String? description;
    String? tags;
    String? token;

    factory Tareas.fromJson(Map<String, dynamic> json) => Tareas(
        id: json["id"],
        title: json["title"],
        isCompleted: json["is_completed"],
        dueDate: json["due_date"],
        comments: json["comments"],
        description: json["description"],
        tags: json["tags"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
        "due_date": dueDate,
        "comments": comments,
        "description": description,
        "tags": tags,
        "token": token,
    };
}
