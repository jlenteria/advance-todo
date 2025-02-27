import 'package:flutter/foundation.dart';

class ViewModel with ChangeNotifier {
  ValueChanged<String>? onErrorListener;

  bool get isLoading => _isLoading;
  bool _isLoading = false;
  bool _isDisposed = false;

  @protected
  void startLoading() {
    if (isLoading) {
      return;
    }
    _isLoading = true;
    notifyListeners();
  }

  @protected
  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) {
      return;
    }
    super.notifyListeners();
  }
  
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
  
}
