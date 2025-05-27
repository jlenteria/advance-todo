import 'package:advance_todo/data/classes/json_result.dart';
import 'package:advance_todo/data/enums/priority_category.dart';
import 'package:advance_todo/domain/models/entities/check_list.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:advance_todo/domain/use_cases/todo_use_cases.dart';
import 'package:advance_todo/presentations/view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class DetailScreenViewModel extends ViewModel {
  DetailScreenViewModel({
    required Todo todo,
  }) : _todo = todo {
    init();
  }

  Future<void> init() async {
    titleController.text = _todo.title;
    dueDateController.text = _todo.dueDate.toString();
    _priorityIndex = _todo.priority;
    _dueDate = _todo.dueDate;
    if (_todo.checkList != null) {
      _checklistItems = _todo.checkList;
      _checklistItemsCompleted =
          _checklistItems!.map((CheckList e) => e.isCompleted).toList();
    }
    _isCompleted = _todo.isCompleted;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TodoUseCases _todoUseCases = TodoUseCases();

  List<String> priorities = PriorityCategory.values
      .map((PriorityCategory priority) => priority.name)
      .toList();
  final Todo _todo;

  DateTime? _dueDate;
  int _priorityIndex = 1;
  List<CheckList>? _checklistItems;
  List<bool>? _checklistItemsCompleted;
  bool _isCompleted = false;

  // getter
  List<bool>? get checklistItemsCompleted => _checklistItemsCompleted;
  List<CheckList>? get checklistItems => _checklistItems;
  Todo get todo => _todo;
  DateTime? get dueDate => _dueDate;
  int get priorityIndex => _priorityIndex;
  bool get isCompleted => _isCompleted;

  bool get isAllChecklistItemsCompleted =>
      _checklistItemsCompleted!.every((e) => e);
  // methods
  void toggleChecklistItem(int index) {
    _checklistItemsCompleted![index] = !_checklistItemsCompleted![index];
    notifyListeners();
  }

  void togglePriority(int index) {
    _priorityIndex = index;
    notifyListeners();
  }

  Future<JsonResult> updateTodo() async {
    final Todo todo = _todo.copyWith(
        dueDate: _dueDate,
        priority: _priorityIndex,
        isCompleted:
            _checklistItems != null ? isAllChecklistItemsCompleted : _isCompleted,
        completedAt: _checklistItems != null && isAllChecklistItemsCompleted
            ? DateTime.now()
            : null,
        checkList: _checklistItems
            ?.map((e) => e.copyWith(
                isCompleted:
                    _checklistItemsCompleted![_checklistItems!.indexOf(e)]))
            .toList());

    final Either<String, bool> result = await _todoUseCases.updateTodo(todo);
    late final JsonResult jsonResult;

    result.fold(
      (l) {
        jsonResult = JsonResult(isError: true, message: l);
      },
      (bool r) {
        jsonResult = JsonResult(message: 'Todo updated successfully');
      },
    );

    return jsonResult;
  }

  Future<JsonResult> deleteTodo() async {
    final Either<String, bool> result =
        await _todoUseCases.deleteTodo(id: _todo.id);
    late final JsonResult jsonResult;
    result.fold((l) {
      jsonResult = JsonResult(isError: true, message: l);
    }, (bool r) {
      jsonResult = JsonResult(message: 'Todo deleted successfully');
    });

    return jsonResult;
  }

  void isCompleteChange() {
    _isCompleted = !_isCompleted;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    dueDateController.dispose();
    super.dispose();
  }
}
