import 'package:hive_flutter/hive_flutter.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:advance_todo/domain/models/entities/check_list.dart';


part 'todo_impl.dart';
class HiveDB with _TodoImpl implements ITodoDao {
  factory HiveDB() => _instance;

  HiveDB._();
  static final HiveDB _instance = HiveDB._();
  late Box<Todo> _todoBox;

  bool _isInit = false;

  @override
  Box<Todo> get todoBox {
    _initCheck();
    return _todoBox;
  }

  Future<void> init({bool retried = false}) async {
    try {
      await Hive.initFlutter();

      Hive.registerAdapter(
        TodoAdapter(),
        override: retried,
      );
      Hive.registerAdapter(
        CheckListAdapter(),
        override: retried,
      );

      _todoBox = await Hive.openBox<Todo>('todo');
      _isInit = true;
    } catch (e) {
      await Future.wait(
        <Future<void>>[
          Hive.deleteBoxFromDisk('todo'),
        ],
      );

      if (!retried) {
        return init(retried: true);
      }
    }
  }

  void _initCheck() {
    assert(
      _isInit,
      'Hive boxes not yet initialized. Call [init] first',
    );
  }

  Future<void> clear() => Future.wait(
    <Future<int>>[
      _todoBox.clear(),
    ],
  );

}
