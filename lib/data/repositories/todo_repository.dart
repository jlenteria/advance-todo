import 'package:advance_todo/data/datasources/local/hive_db.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class TodoRepository {
  Future<Either<String, List<Todo>>> getTodos() async {
    try {
      final ITodoDao dao = HiveDB();
      final List<Todo> todos = dao.getTodos();
      return right(todos);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> addTodo(Todo todo) async {
    try {
      final ITodoDao dao = HiveDB();
      await dao.addTodo(todo);
      return right(true);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> updateTodo(Todo todo) async {
    try {
      final ITodoDao dao = HiveDB();
      await dao.updateTodo(todo);
      return right(true);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteTodo({
    required int id,
  }) async {
    try {
      final ITodoDao dao = HiveDB();
      await dao.deleteTodo(id);
      return right(true);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, int>> getTodoCurrentId() async {
    try {
      final ITodoDao dao = HiveDB();
      final int currentId = await dao.getTodoCurrentId();
      return right(currentId);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }
}
