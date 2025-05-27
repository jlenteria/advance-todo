import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:advance_todo/data/enums/priority_category.dart';
import 'package:advance_todo/domain/models/entities/todo.dart';
import 'package:advance_todo/presentations/screens/dashboard/dashboard_screen_view_model.dart';
import 'package:advance_todo/presentations/widgets/app_background.dart';
import 'package:advance_todo/presentations/widgets/custom_app_bar.dart';
import 'package:advance_todo/presentations/widgets/custom_circular_progress_indicator.dart';
import 'package:advance_todo/presentations/widgets/line_divider.dart';
import 'package:advance_todo/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: RefreshIndicator(
          onRefresh: context.read<DashboardScreenViewModel>().init,
          child: Column(
            children: <Widget>[
              const CustomAppBar(
                title: 'My Todos',
                hideBackButton: true,
              ),
              Consumer<DashboardScreenViewModel>(
                builder: (_, DashboardScreenViewModel vm, __) {
                  if (vm.isLoading) {
                    return const Center(
                        heightFactor: 10, child: CircularProgressIndicator());
                  }
                  if (vm.overdueTodos.isEmpty && vm.todayTodos.isEmpty && vm.upcomingTodos.isEmpty) {
                    return Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'No todos yet',
                          style: AppFonts.body16M(),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomScrollView(
                      slivers: [
                        if (vm.overdueTodos.isEmpty && vm.todayTodos.isEmpty && vm.upcomingTodos.isEmpty)
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'No todos yet',
                              style: AppFonts.body16M(),
                            ),
                          ),
                        if (vm.overdueTodos.isNotEmpty)
                        SliverToBoxAdapter(
                          child: SizedBox(height: 25),
                        ),
                        if (vm.overdueTodos.isNotEmpty)
                          SliverToBoxAdapter(
                            child: _OverDueTodo(todos: vm.overdueTodos),
                          ),
                        if (vm.todayTodos.isNotEmpty)
                          SliverToBoxAdapter(
                            child: SizedBox(height: 25),
                          ),
                        if (vm.todayTodos.isNotEmpty)
                          SliverToBoxAdapter(
                            child: _TodayTodo(todos: vm.todayTodos),
                          ),
                        if (vm.upcomingTodos.isNotEmpty)
                          SliverToBoxAdapter(
                            child: SizedBox(height: 25),
                          ),
                        if (vm.upcomingTodos.isNotEmpty)
                          SliverToBoxAdapter(
                            child: _UpcomingTodo(todos: vm.upcomingTodos),
                          ),
                       
                        SliverToBoxAdapter(
                          child: SizedBox(height: 120),
                        ),
                      ],
                    ),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverDueTodo extends StatelessWidget {
  const _OverDueTodo({required this.todos});
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Overdue', style: AppFonts.body16SB(color: Colors.red)),
        const SizedBox(
          height: 10,
        ),
        const LineDivider(),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: todos.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, int index) => _TodoItem(
            todo: todos[index],
            isOverDue: true,
          ),
        ),
      ],
    );
  }
}

class _TodayTodo extends StatelessWidget {
  const _TodayTodo({required this.todos});
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Today', style: AppFonts.body16SB()),
        const SizedBox(
          height: 10,
        ),
        const LineDivider(),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: todos.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, int index) => _TodoItem(
              todo: todos[index],
              isToday: true,
            ))
      ],
    );
  }
}

class _UpcomingTodo extends StatelessWidget {
  const _UpcomingTodo({required this.todos});
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Upcoming', style: AppFonts.body16SB()),
        const SizedBox(
          height: 10,
        ),
        const LineDivider(),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: todos.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, int index) => _TodoItem(
          todo: todos[index],
          ),
        ),
      ],
    );
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({
    required this.todo,
    this.isOverDue = false,
    this.isToday = false,
  });
  final bool isOverDue;
  final bool isToday;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final String badgeText =
        PriorityCategory.values[todo.priority] == PriorityCategory.URGENT
            ? 'URGENT'
            : PriorityCategory.values[todo.priority] == PriorityCategory.NORMAL
                ? 'NORMAL'
                : 'LOW';

    final Color badgeColor =
        PriorityCategory.values[todo.priority] == PriorityCategory.URGENT
            ? Colors.red
            : PriorityCategory.values[todo.priority] == PriorityCategory.NORMAL
                ? Colors.blue
                : Colors.grey;

    return Stack(
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: isOverDue ? Colors.red : Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Selector<DashboardScreenViewModel, double>(
                    selector: (_, DashboardScreenViewModel vm) =>
                        vm.getPercentage(todo),
                    builder: (_, double percentage, __) =>
                        CustomCircularProgressIndicator(
                      percentage: percentage,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        todo.title,
                        style: AppFonts.body14SB(color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        dateFormatter(todo.dueDate),
                        style: AppFonts.body12R(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            context.push(TodoDetailRoute().location, extra: todo);
          },
        ),
        //Badge
        if (isToday)
          Positioned(
            top: 0,
            right: 0,
            child: Badge(
              label: Text(
                badgeText,
                style: AppFonts.body10B(color: Colors.white),
              ),
              offset: const Offset(12, -12),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              backgroundColor: badgeColor,
            ),
          ),
      ],
    );
  }
}

String dateFormatter(DateTime date) {
  return DateFormat('MMM dd, yyyy hh:mm a').format(date);
}
