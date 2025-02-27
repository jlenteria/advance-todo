import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:advance_todo/data/enums/priority_category.dart';
import 'package:advance_todo/presentations/widgets/line_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('My Todos'),
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: const CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  SliverToBoxAdapter(
                    child: _OverDueTodo(),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 25),
                  ),
                  SliverToBoxAdapter(
                    child: _TodayTodo(),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 25),
                  ),
                  SliverToBoxAdapter(
                    child: _UpcomingTodo(),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                ],
              ))),
    );
  }
}

class _OverDueTodo extends StatelessWidget {
  const _OverDueTodo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Overdue', style: AppFonts.body16M(color: Colors.red)),
        const SizedBox(
          height: 10,
        ),
        const LineDivider(),
        const SizedBox(
          height: 15,
        ),
        const _TodoItem(
          title: 'Learn Flutter',
          date: 'Feb 28, 2024',
          isOverDue: true,
        ),
        const SizedBox(
          height: 10,
        ),
        const _TodoItem(
          title: 'Learn Flutter',
          date: 'Feb 28, 2024',
          isOverDue: true,
        ),
      ],
    );
  }
}

class _TodayTodo extends StatelessWidget {
  const _TodayTodo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Today', style: AppFonts.body16M()),
        const SizedBox(
          height: 10,
        ),
        const LineDivider(),
        const SizedBox(
          height: 15,
        ),
        const _TodoItem(
          title: 'Learn Flutter',
          date: 'Feb 28, 2025',
          priority: PriorityCategory.HIGH,
        ),
        const SizedBox(
          height: 10,
        ),
        const _TodoItem(
          title: 'Learn Flutter',
          date: 'Feb 28, 2025',
          priority: PriorityCategory.LOW
        ),
      ],
    );
  }
}

class _UpcomingTodo extends StatelessWidget {
  const _UpcomingTodo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Upcoming', style: AppFonts.body16M()),
        const SizedBox(
          height: 10,
        ),
        const LineDivider(),
        const SizedBox(
          height: 15,
        ),
        const _TodoItem(title: 'Learn Flutter Advanced', date: 'March 6, 2025'),
        const SizedBox(
          height: 10,
        ),
        const _TodoItem(
          title: 'Learn Flutter Advanced 2',
          date: 'March 7, 2025'
        ),
      ],
    );
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({
    required this.title,
    required this.date,
    this.priority,
    this.isOverDue = false,
  });

  final String title;
  final String date;
  final PriorityCategory? priority;
  final bool isOverDue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: isOverDue ? Colors.red : Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.circle_outlined,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppFonts.body14SB(color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        date,
                        style: AppFonts.body12R(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {},
        ),
        //Badge
        if (priority == PriorityCategory.HIGH)
          Positioned(
            top: 0,
            right: 0,
            child: Badge(
              label: Text(
                'URGENT',
                style: AppFonts.body10B(color: Colors.white),
              ),
              offset: const Offset(12, -12),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              backgroundColor: Colors.red,
            ),
          ),
        if (priority == PriorityCategory.NORMAL)
          Positioned(
            top: 0,
            right: 0,
            child: Badge(
              label: Text(
                'NORMAL',
                style: AppFonts.body10B(color: Colors.white),
              ),
              offset: const Offset(12, -12),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              backgroundColor: Colors.blue,
            ),
          ),
        if (priority == PriorityCategory.LOW)
          Positioned(
            top: 0,
            right: 0,
            child: Badge(
              label: Text(
                'LOW',
                style: AppFonts.body10B(color: Colors.white),
              ),
              offset: const Offset(12, -12),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              backgroundColor: Colors.grey,
            ),
          ),
      ],
    );
  }
}
