import 'package:advance_todo/data/enums/priority_category.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Todo {
  const Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.progress,
    this.priority,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  @JsonKey(name: 'due_date')
  final DateTime dueDate;
  @HiveField(3)
  final PriorityCategory? priority;
  @HiveField(4)
  final int progress;
}
