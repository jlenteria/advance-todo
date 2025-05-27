import 'package:advance_todo/router/router.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, {bool isError = true}) {
  ScaffoldMessenger.of(
    appRouter.routerDelegate.navigatorKey.currentContext!,
  )
    ..clearSnackBars() // avoid multiple snackbars
    ..showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Color(0xFF17563C),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
        showCloseIcon: true,
        content: Text(message),
      ),
    );
}