import 'package:advance_todo/data/repositories/todo_repository.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:dartz/dartz.dart';

class TodoUseCases {
  final TodoRepository _repository = TodoRepository();

  Future<Either<String, List<Todo>>> getTodos() => _repository.getTodos();
  Future<Either<String, bool>> addTodo(Todo todo) =>
      _repository.addTodo(todo);  
  Future<Either<String, bool>> updateTodo(Todo todo) =>
      _repository.updateTodo(todo);
  Future<Either<String, bool>> deleteTodo({
    required int id,
  }) =>
      _repository.deleteTodo(id: id);
  Future<Either<String, int>> getTodoCurrentId() =>
      _repository.getTodoCurrentId();
}
