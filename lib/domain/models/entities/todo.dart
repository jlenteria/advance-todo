import 'package:advance_todo/domain/models/entities/check_list.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';
@HiveType(typeId: 0)
class Todo {
  const Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.completedAt,
    this.isCompleted = false,
    this.priority = 1, // normal
    this.checkList,
  });
  

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime dueDate;
  @HiveField(3)
  final int priority;
  @HiveField(4)
  final DateTime? completedAt;
  @HiveField(5)
  final List<CheckList>? checkList;
  @HiveField(6)
  final bool isCompleted;
  
  Todo copyWith({
    int? id,
    String? title,
    DateTime? dueDate,
    int? priority,
    DateTime? completedAt,
    bool? isCompleted,
    List<CheckList>? checkList,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        priority: priority ?? this.priority,
        completedAt: completedAt ?? this.completedAt,
        isCompleted: isCompleted ?? this.isCompleted,
        checkList: checkList ?? this.checkList,
      );

}