import 'package:hive/hive.dart';
part 'check_list.g.dart';

@HiveType(typeId: 1)
class CheckList {
  const CheckList({
    required this.title,
    required this.isCompleted,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool isCompleted;

  CheckList copyWith({
    bool? isCompleted,
  }) =>
      CheckList(
        title: title,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}