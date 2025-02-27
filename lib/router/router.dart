import 'package:advance_todo/core/constants/global/global_keys.dart';
import 'package:advance_todo/presentations/screens/dashboard/dashboard_screen.dart';
import 'package:advance_todo/presentations/screens/dashboard/dashboard_screen_view_model.dart';
import 'package:advance_todo/presentations/screens/done_todo/done_todo_screen.dart';
import 'package:advance_todo/presentations/screens/done_todo/done_todo_screen_view_model.dart';
import 'package:advance_todo/presentations/screens/scheduler/scheduler_screen.dart';
import 'package:advance_todo/presentations/screens/scheduler/scheduler_screen_view_model.dart';
import 'package:advance_todo/presentations/screens/settings/settings_screen.dart';
import 'package:advance_todo/presentations/screens/settings/settings_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import "package:advance_todo/presentations/screens/home_screen.dart";
import "package:advance_todo/presentations/screens/home_screen_view_model.dart";
import 'package:provider/provider.dart';

part 'home_route.dart';
part 'router.g.dart';

typedef Builder = Widget Function(
  BuildContext context,
  GoRouterState routerState,
);

class ScreenRoute {
  ScreenRoute({required this.builder});

  Builder builder;
}

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    ...$appRoutes,
  ],
  initialLocation: '/dashboard',
  redirect: _handleRedirect,
);

String? _handleRedirect(BuildContext context, GoRouterState state) {
  return null;
}

abstract class BaseRoute extends GoRouteData {
  const BaseRoute();

  Widget buildScreen(BuildContext context, GoRouterState state);

  @override
  Page<dynamic> buildPage(BuildContext context, GoRouterState state) =>
      CupertinoPage<dynamic>(child: buildScreen(context, state));
}
