import 'package:advance_todo/core/constants/bottom_padding.dart';
import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:advance_todo/data/classes/json_result.dart';
import 'package:advance_todo/presentations/screens/dashboard/dashboard_screen_view_model.dart';
import 'package:advance_todo/presentations/screens/detail/detail_screen_view_model.dart';
import 'package:advance_todo/presentations/widgets/app_background.dart';
import 'package:advance_todo/presentations/widgets/custom_app_bar.dart';
import 'package:advance_todo/presentations/widgets/custom_snack_bar.dart';
import 'package:advance_todo/presentations/widgets/line_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: RefreshIndicator(
          onRefresh: context.read<DetailScreenViewModel>().init,
          child: Column(
            children: <Widget>[
              CustomAppBar(
                title: 'Todo Detail',
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: const SizedBox(
                        height: 20,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _DetailBody(),
                    ),
                    SliverToBoxAdapter(
                      child: const SizedBox(
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: () async {
                  final JsonResult res =
                      await context.read<DetailScreenViewModel>().updateTodo();

                  if (res.isError) {
                    showSnackBar(res.message);
                  } else {
                    DashboardScreenViewModel().init();
                    showSnackBar(res.message, isError: false);
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                },
                minSize: 0,
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(18),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, context.bottomPadding),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'UPDATE',
                    style: AppFonts.body16B(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody();

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailScreenViewModel>(
      builder: (_, DetailScreenViewModel vm, __) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      vm.todo.title.toUpperCase(),
                      style: AppFonts.body16B(),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final JsonResult res = await vm.deleteTodo();
                      if (res.isError) {
                        showSnackBar(res.message);
                      } else {
                        DashboardScreenViewModel().init();
                        showSnackBar(res.message, isError: false);
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.delete_rounded, color: Colors.red),
                  ),
                ],
              ),
              const LineDivider(),
              const SizedBox(height: 30),
              const _CheckList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Due Date',
                    style: AppFonts.body14B(),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('MMM dd, yyyy hh:mm a').format(vm.dueDate!),
                    style: AppFonts.body14B(),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Priority',
                    style: AppFonts.body14B(),
                  ),
                  const SizedBox(width: 10),
                  CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    onPressed: () => _showDialog(
                      context,
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: 32,
                        scrollController: FixedExtentScrollController(
                          initialItem: vm.priorityIndex,
                        ),
                        onSelectedItemChanged: (int index) {
                          vm.togglePriority(index);
                        },
                        children: List<Widget>.generate(vm.priorities.length,
                            (int index) {
                          return Center(
                            child: Text(
                              vm.priorities[index],
                            ),
                          );
                        }),
                      ),
                    ),
                    child: Text(
                      vm.priorities[vm.priorityIndex],
                      style: AppFonts.body12B(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (vm.checklistItems == null)
                InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => vm.isCompleteChange(),
                  child: Transform.translate(
                    offset: const Offset(-12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Checkbox(
                          checkColor: Colors.white,
                          value: vm.isCompleted,
                          onChanged: (bool? value) => vm.isCompleteChange(),
                        ),
                        const SizedBox(width: 2,),
                        Flexible(
                          child: Text(
                            'Is Completed ?',
                            style: AppFonts.body12B(),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class _CheckList extends StatelessWidget {
  const _CheckList();

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailScreenViewModel>(
      builder: (_, DetailScreenViewModel vm, __) {
        if (vm.checklistItems == null) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Checklist:', style: AppFonts.body14B()),
            const SizedBox(height: 10),
            ListView.separated(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                itemCount: vm.checklistItems!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 1),
                itemBuilder: (_, int index) => InkWell(
                      onTap: () => vm.toggleChecklistItem(index),
                      child: Transform.translate(
                        offset: const Offset(-12, 0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.green,
                              value: vm.checklistItemsCompleted![index],
                              onChanged: (bool? value) {
                                vm.toggleChecklistItem(index);
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            Expanded(
                              child: Text(
                                vm.checklistItems![index].title,
                                style: AppFonts.body12B(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
          ],
        );
      },
    );
  }
}
