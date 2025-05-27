
part of 'router.dart';

@TypedGoRoute<FormRoute>(path: '/form')
class FormRoute extends BaseRoute {
  const FormRoute() : super();
  @override
  Widget buildScreen(BuildContext context, GoRouterState state) =>
      ChangeNotifierProvider<FormScreenViewModel>(
          create: (_) => FormScreenViewModel(),
          child: const FormScreen());
}
