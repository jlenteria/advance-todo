// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeShellRoute,
      $formRoute,
      $todoDetailRoute,
    ];

RouteBase get $homeShellRoute => StatefulShellRouteData.$route(
      restorationScopeId: HomeShellRoute.$restorationScopeId,
      navigatorContainerBuilder: HomeShellRoute.$navigatorContainerBuilder,
      factory: $HomeShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          restorationScopeId: HomeBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/dashboard',
              factory: $DashboardRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          restorationScopeId: DoneTodoBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/completed',
              factory: $DoneTodoRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          restorationScopeId: SchedulerBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/scheduler',
              factory: $SchedulerRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          restorationScopeId: SettingsBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/settings',
              factory: $SettingsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

extension $DashboardRouteExtension on DashboardRoute {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  String get location => GoRouteData.$location(
        '/dashboard',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DoneTodoRouteExtension on DoneTodoRoute {
  static DoneTodoRoute _fromState(GoRouterState state) => const DoneTodoRoute();

  String get location => GoRouteData.$location(
        '/completed',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SchedulerRouteExtension on SchedulerRoute {
  static SchedulerRoute _fromState(GoRouterState state) =>
      const SchedulerRoute();

  String get location => GoRouteData.$location(
        '/scheduler',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $formRoute => GoRouteData.$route(
      path: '/form',
      factory: $FormRouteExtension._fromState,
    );

extension $FormRouteExtension on FormRoute {
  static FormRoute _fromState(GoRouterState state) => const FormRoute();

  String get location => GoRouteData.$location(
        '/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $todoDetailRoute => GoRouteData.$route(
      path: '/todo-detail',
      factory: $TodoDetailRouteExtension._fromState,
    );

extension $TodoDetailRouteExtension on TodoDetailRoute {
  static TodoDetailRoute _fromState(GoRouterState state) =>
      const TodoDetailRoute();

  String get location => GoRouteData.$location(
        '/todo-detail',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
