import 'package:advance_todo/presentations/view_model.dart';

class HomeScreenViewModel extends ViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    if (_currentIndex == value) {
      return;
    }
    _currentIndex = value;
    notifyListeners();
  }
}
