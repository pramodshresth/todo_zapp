
import 'dart:convert';

class AddTodoModel {
  final String title;
  final bool completed;

  AddTodoModel({
    required this.title,
    required this.completed,
  });

  AddTodoModel copyWith({
    String? title,
    bool? completed,
  }) =>
      AddTodoModel(
        title: title ?? this.title,
        completed: completed ?? this.completed,
      );

  factory AddTodoModel.fromRawJson(String str) => AddTodoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTodoModel.fromJson(Map<String, dynamic> json) => AddTodoModel(
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "completed": completed,
  };
}
