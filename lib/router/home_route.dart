part of 'router.dart';

@TypedStatefulShellRoute<HomeShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DashboardRoute>(path: '/dashboard'),
      ],
    ),
    TypedStatefulShellBranch<DoneTodoBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DoneTodoRoute>(path: '/completed'),
      ],
    ),
    TypedStatefulShellBranch<SchedulerBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SchedulerRoute>(path: '/scheduler'),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(path: '/settings'),
      ],
    ),
  ],
)
class HomeShellRoute extends StatefulShellRouteData {
  const HomeShellRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = homeShellRouteKey;
  static const String $restorationScopeId = 'HomeShellRouteRestorationScopeId';

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return navigationShell;
  }

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return ChangeNotifierProvider<HomeScreenViewModel>(
      create: (_) => HomeScreenViewModel(),
      child: HomeScreen(
        statefulNavigationShell: navigationShell,
        children: children,
      ),
    );
  }
}

class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();

  static const String $restorationScopeId = 'HomeBranchDataRestorationId';
}

class DashboardBranchData extends StatefulShellBranchData {
  const DashboardBranchData();

  static const String $restorationScopeId =
      'HomeBranchDataShellRouteRestorationId';
}


class DoneTodoBranchData extends StatefulShellBranchData {
  const DoneTodoBranchData();

  static const String $restorationScopeId =
      'DoneTodoBranchDataShellRouteRestorationId';
}

class SchedulerBranchData extends StatefulShellBranchData {
  const SchedulerBranchData();

  static const String $restorationScopeId =
      'SchedulerBranchDataShellRouteRestorationId';
}

class SettingsBranchData extends StatefulShellBranchData {
  const SettingsBranchData();

  static const String $restorationScopeId =
      'SettingsBranchDataShellRouteRestorationId';
}

class DashboardRoute extends BaseRoute {
  const DashboardRoute() : super();
  @override
  Widget buildScreen(BuildContext context, GoRouterState state) =>
      ChangeNotifierProvider<DashboardScreenViewModel>(
          create: (_) => DashboardScreenViewModel(),
          child: const DashboardScreen());
}

class DoneTodoRoute extends BaseRoute {
  const DoneTodoRoute() : super();
  @override
  Widget buildScreen(BuildContext context, GoRouterState state) =>
      ChangeNotifierProvider<CompletedScreenViewModel>(
          create: (_) => CompletedScreenViewModel(),
          child: const CompletedScreen());
}

class SchedulerRoute extends BaseRoute {
  const SchedulerRoute() : super();
  @override
  Widget buildScreen(BuildContext context, GoRouterState state) =>
      ChangeNotifierProvider<SchedulerScreenViewModel>(
          create: (_) => SchedulerScreenViewModel(),
          child: const SchedulerScreen());
}

class SettingsRoute extends BaseRoute {
  const SettingsRoute() : super();
  @override
  Widget buildScreen(BuildContext context, GoRouterState state) =>
      ChangeNotifierProvider<SettingsScreenViewModel>(
          create: (_) => SettingsScreenViewModel(),
          child: const SettingsScreen());
}
  