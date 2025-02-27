import 'package:advance_todo/data/datasources/local/hive_db.dart';
import 'package:advance_todo/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await HiveDB().init();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) {
        return MaterialApp.router(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.routerDelegate,
          routeInformationProvider: appRouter.routeInformationProvider,
          routeInformationParser: appRouter.routeInformationParser,
          locale: const Locale('en'),
        );
      }
    );
  }
}
