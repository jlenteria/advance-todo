import 'package:hive_flutter/hive_flutter.dart';

class HiveDB {
  factory HiveDB() => _instance;

  HiveDB._();
  static final HiveDB _instance = HiveDB._();
  bool _isInit = false;

  Future<void> init({bool retried = false}) async {
    try {
      await Hive.initFlutter();

      // Hive.registerAdapter();
      _isInit = true;
    } catch (e) {
      await Future.wait(
        <Future<void>>[
          // Hive.deleteBoxFromDisk('todo'),
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
    ],
  );
}
