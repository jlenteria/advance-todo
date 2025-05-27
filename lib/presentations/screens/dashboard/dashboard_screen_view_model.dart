import 'package:advance_todo/data/classes/json_result.dart';
import 'package:advance_todo/domain/models/entities/check_list.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:advance_todo/domain/use_cases/todo_use_cases.dart';
import 'package:advance_todo/presentations/view_model.dart';
import 'package:dartz/dartz.dart';

class DashboardScreenViewModel extends ViewModel {
  factory DashboardScreenViewModel() {
    _instance ??= DashboardScreenViewModel._();
    return _instance!;
  }
  static DashboardScreenViewModel? _instance;

  DashboardScreenViewModel._() {
    init();
  }
  final TodoUseCases _todoUseCases = TodoUseCases();
  final List<Todo> _todos = <Todo>[];
  List<Todo> get todos => _todos;

  List<Todo> get overdueTodos => _todos
      .where((Todo todo) =>
          todo.dueDate.isBefore(DateTime.now()) && !todo.isCompleted)
      .toList();
  List<Todo> get todayTodos {
    final DateTime now = DateTime.now();
    return _todos.where((Todo todo) {
      final bool isSameDay = todo.dueDate.year == now.year &&
          todo.dueDate.month == now.month &&
          todo.dueDate.day == now.day;
      final bool isAfterCurrentTime =
          todo.dueDate.isAfter(now) || todo.dueDate.isAtSameMomentAs(now);
      final bool isCompleted = todo.isCompleted;
      return isSameDay && isAfterCurrentTime && !isCompleted;
    }).toList();
  }

  List<Todo> get upcomingTodos {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return _todos.where((Todo todo) {
      final bool isCompleted = todo.isCompleted;
      return todo.dueDate.isAfter(today) && !isCompleted;
    }).toList();
  }

  Future<void> init() async {
    startLoading();
    final Either<String, List<Todo>> result = await _todoUseCases.getTodos();

    result.fold(
      (l) => onErrorListener?.call(l),
      (List<Todo> r) {
        _todos.clear();
        if (r.isNotEmpty) {
          _todos.addAll(r);
        }
      },
    );
    stopLoading();
  }

  Future<JsonResult> deleteTodo(int id) async {
    final Either<String, bool> result = await _todoUseCases.deleteTodo(id: id);
    late final JsonResult jsonResult;
    result.fold(
      (l) => jsonResult = JsonResult(isError: true, message: l),
      (bool r) {
        final bool isError = r ? false : true;
        jsonResult =
            JsonResult(isError: isError, message: 'Todo deleted successfully');
      },
    );
    return jsonResult;
  }

  double getPercentage(Todo todo) {
    final double todoTotal = todo.isCompleted ? 1 : 0;
    final int checkListTotal = todo.checkList?.length ?? 0;
    final int checkListCompleted =
        todo.checkList?.where((CheckList item) => item.isCompleted).length ?? 0;
    return todo.checkList != null
        ? checkListTotal > 0
            ? checkListCompleted / checkListTotal
            : 0
        : todoTotal;
  }

  @override
  void dispose() {
    super.dispose();
    _instance = null;
  }
}
