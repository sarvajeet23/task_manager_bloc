import 'dart:convert';

class TodoModel {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoModel({this.id, this.todo, this.completed, this.userId}) {
    id ??= DateTime.now().millisecondsSinceEpoch; // Assign unique ID if null
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'todo': todo, 'completed': completed, 'userId': userId};
  }

  /// ✅ New copyWith method
  TodoModel copyWith({int? id, String? todo, bool? completed, int? userId}) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
