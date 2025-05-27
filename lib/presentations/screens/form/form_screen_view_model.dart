import 'package:advance_todo/data/classes/json_result.dart';
import 'package:advance_todo/data/enums/priority_category.dart';
import 'package:advance_todo/domain/models/entities/check_list.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:advance_todo/domain/use_cases/todo_use_cases.dart';
import 'package:advance_todo/presentations/view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class FormScreenViewModel extends ViewModel {
  FormScreenViewModel() {
    loadTodoCurrentId();
  }
  late final TextEditingController titleController = TextEditingController()
    ..addListener(notifyListeners);
  late final TextEditingController dueDateController = TextEditingController()
    ..addListener(notifyListeners);
  late final TextEditingController checklistController = TextEditingController()
    ..addListener(notifyListeners);

  final TodoUseCases _todoUseCases = TodoUseCases();

  // setter
  DateTime? _dueDate;
  int _priorityIndex = 1;
  int _currentId = 0;
  List<String> priorities = PriorityCategory.values
      .map((PriorityCategory priority) => priority.name)
      .toList();
  List<CheckList>? _checklistItems;
  bool _isResetForm = false;

  // getter
  DateTime? get dueDate => _dueDate;
  int get currentId => _currentId;
  int get priorityIndex => _priorityIndex;
  List<CheckList>? get checklistItems => _checklistItems;
  bool get canProceed {
    final bool hasTitle = titleController.text.isNotEmpty;
    final bool hasDueDate = dueDateController.text.isNotEmpty;
    return hasTitle && hasDueDate;
  }

  bool get isResetForm => _isResetForm;

  // methods

  void loadTodoCurrentId() async {
    final Either<String, int> result = await _todoUseCases.getTodoCurrentId();
    result.fold(
      (l) => onErrorListener?.call(l),
      (int r) => _currentId = r,
    );
  }

  void onDueDateChanged(DateTime date) {
    if (_dueDate == date) {
      return;
    }
    _dueDate = date;
    notifyListeners();
  }

  void onPriorityChanged(int index) {
    if (_priorityIndex == index) {
      return;
    }
    _priorityIndex = index;
    notifyListeners();
  }

  void addChecklistItem(String item) {
    _checklistItems ??= <CheckList>[];
    _checklistItems!.add(CheckList(
      title: item,
      isCompleted: false
    ));
    notifyListeners();
  }

  void removeChecklistItem(CheckList item) {
    _checklistItems?.remove(item);
    notifyListeners();
  }

  void clearChecklist() {
    _checklistItems = null;
    notifyListeners();
  }

  Future<JsonResult> addTodo() async {
    _currentId++;
    final Todo todo = Todo(
      title: titleController.text,
      dueDate: dueDate!,
      priority: PriorityCategory.values[_priorityIndex].index,
      checkList: checklistItems,
      completedAt: null,
      id: currentId,
    );

    final Either<String, bool> result = await _todoUseCases.addTodo(todo);
    late final JsonResult jsonResult;

    result.fold(
      (l) {
        jsonResult = JsonResult(isError: true, message: l);
        _currentId--;
      },
      (bool r) {
        _resetForm();
        jsonResult =
            JsonResult(isError: false, message: 'Todo added successfully');
      },
    );

    return jsonResult;
  }

  void _resetForm() {
    _isResetForm = true;
    titleController.clear();
    dueDateController.clear();
    checklistController.clear();
    _priorityIndex = 1;
    _checklistItems = null;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.removeListener(notifyListeners);
    titleController.dispose();
    dueDateController.removeListener(notifyListeners);
    dueDateController.dispose();
    checklistController.removeListener(notifyListeners);
    checklistController.dispose();
    super.dispose();
  }
}
