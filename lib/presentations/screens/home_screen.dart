import 'dart:ui';

import 'package:advance_todo/core/constants/bottom_padding.dart';
import 'package:advance_todo/presentations/screens/home_screen_view_model.dart';
import 'package:advance_todo/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key,
      required this.children,
      required this.statefulNavigationShell});

  final List<Widget> children;
  final StatefulNavigationShell statefulNavigationShell;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: IndexedStack(
            index: statefulNavigationShell.currentIndex,
            children: children,
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: _BottomNavBar(),
        ),
        Positioned(
          bottom: 100,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              context.push(const FormRoute().location);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  void _setSelectedIndex(BuildContext context, int index) {
    if (index == 0) {
      const DashboardRoute().go(context);
    } else if (index == 1) {
      const DoneTodoRoute().go(context);
    } else if (index == 2) {
      const SchedulerRoute().go(context);
    } else if (index == 3) {
      const SettingsRoute().go(context);
    }

    context.read<HomeScreenViewModel>().currentIndex = index;
  }

  Widget _buildItem({
    required int index,
    required Widget icon,
    required ValueSetter<int> onTap,
    required bool isSelected,
  }) {
    return Expanded(
        child: IconButton(
      padding: const EdgeInsets.all(12),
      style: IconButton.styleFrom(
          backgroundColor: isSelected ? Colors.orange : Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10),
          ))),
      onPressed: () => onTap(index),
      icon: icon,
    ));
  }

  @override
  Widget build(BuildContext context) {
    const double size = 24;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, context.bottomPadding),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 28,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Consumer<HomeScreenViewModel>(
              builder: (_, HomeScreenViewModel vm, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildItem(
                  index: 0,
                  isSelected: vm.currentIndex == 0,
                  icon: Icon(
                    Icons.home,
                    size: size,
                    color: vm.currentIndex == 0 ? Colors.white : Colors.black,
                  ),
                  onTap: (int i) => _setSelectedIndex(context, 0),
                ),
                _buildItem(
                  index: 1,
                  isSelected: vm.currentIndex == 1,
                  icon: Icon(
                    Icons.check_box,
                    size: size,
                    color: vm.currentIndex == 1 ? Colors.white : Colors.black,
                  ),
                  onTap: (int i) => _setSelectedIndex(context, 1),
                ),
                _buildItem(
                  index: 2,
                  isSelected: vm.currentIndex == 2,
                  icon: Icon(
                    Icons.calendar_month,
                    size: size,
                    color: vm.currentIndex == 2 ? Colors.white : Colors.black,
                  ),
                  onTap: (int i) => _setSelectedIndex(context, 2),
                ),
                _buildItem(
                  index: 3,
                  isSelected: vm.currentIndex == 3,
                  icon: Icon(
                    Icons.settings_outlined,
                    size: size,
                    color: vm.currentIndex == 3 ? Colors.white : Colors.black,
                  ),
                  onTap: (int i) => _setSelectedIndex(context, 3),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
