part of 'router.dart';

@TypedGoRoute<TodoDetailRoute>(path: '/todo-detail')
class TodoDetailRoute extends BaseRoute {
  const TodoDetailRoute() : super();

  @override
  Widget buildScreen(BuildContext context, GoRouterState state)  {
    final Todo todo = state.extra! as Todo;
    return ChangeNotifierProvider<DetailScreenViewModel>(
      create: (_) => DetailScreenViewModel(todo: todo),
      child: const DetailScreen(),
    );
  }
}

