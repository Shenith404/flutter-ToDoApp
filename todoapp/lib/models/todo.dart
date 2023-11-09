import 'package:flutter/material.dart';

class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Morning exercise", isDone: true),
      ToDo(id: "02", todoText: "Buy groceries", isDone: false),
      ToDo(id: "03", todoText: "Read a book", isDone: false),
      ToDo(id: "04", todoText: "Complete project", isDone: false),
      ToDo(id: "05", todoText: "Call a friend", isDone: false),
    ];
  }
}
