part of 'hive_db.dart';

abstract class ITodoDao {
  List<Todo> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int key);
  Future<int> getTodoCurrentId();
}

mixin _TodoImpl implements ITodoDao {
  Box<Todo> get todoBox;

  @override
  List<Todo> getTodos() => todoBox.values.toList();

  @override
  Future<void> addTodo(Todo todo) => todoBox.add(todo);

  @override
  Future<void> updateTodo(Todo todo) async {
    final map = todoBox.toMap();
    final int key = map.entries.firstWhere((e) => e.value.id == todo.id).key;
    await todoBox.put(key, todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    final map = todoBox.toMap();
    final int key = map.entries.firstWhere((e) => e.value.id == id).key;
    await todoBox.delete(key);
  }

  @override
  Future<int> getTodoCurrentId() async {
    final List<Todo> todos = todoBox.values.toList();
    return todos.isNotEmpty ? todos.last.id : 0;
  }
}
