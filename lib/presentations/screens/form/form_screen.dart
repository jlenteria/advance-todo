import 'package:advance_todo/core/constants/bottom_padding.dart';
import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:advance_todo/data/classes/json_result.dart';
import 'package:advance_todo/presentations/screens/dashboard/dashboard_screen_view_model.dart';
import 'package:advance_todo/presentations/screens/form/form_screen_view_model.dart';
import 'package:advance_todo/presentations/widgets/custom_app_bar.dart';
import 'package:advance_todo/presentations/widgets/custom_date_field.dart';
import 'package:advance_todo/presentations/widgets/custom_snack_bar.dart';
import 'package:advance_todo/presentations/widgets/custom_text_form_field.dart';
import 'package:advance_todo/presentations/widgets/line_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_background.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormScreenViewModel vm = context.read<FormScreenViewModel>();
    vm.onErrorListener = showSnackBar;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Add Todo',
              onPressed: () async {
                await DashboardScreenViewModel().init();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
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
                    child: const _Form(),
                  ),
                  SliverToBoxAdapter(
                    child: const SizedBox(height: 80),
                  ),
                ],
              ),
            ),
            Selector<FormScreenViewModel, bool>(
              selector: (_, FormScreenViewModel vm) => vm.canProceed,
              builder: (_, bool canProceed, __) {
                return CupertinoButton(
                  onPressed: canProceed
                      ? () async {
                          final JsonResult result = await vm.addTodo();
                          if (result.isError) {
                            showSnackBar(result.message);
                          } else {
                            DashboardScreenViewModel().init();
                            showSnackBar(result.message, isError: false);
                            Future.delayed(const Duration(seconds: 1), () {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        }
                      : null,
                  minSize: 0,
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(18),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, context.bottomPadding),
                    decoration: BoxDecoration(
                      color: canProceed ? Colors.orange : Colors.orange[200],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'ADD',
                      style: AppFonts.body16B(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

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
    return Consumer<FormScreenViewModel>(
        builder: (_, FormScreenViewModel vm, __) {
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
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Title',
                style: AppFonts.body14SB(),
              ),
              const SizedBox(height: 8),
              Selector<FormScreenViewModel, bool>(
                selector: (_, FormScreenViewModel vm) => vm.isResetForm,
                builder: (_, bool isResetForm, __) {
                  return CustomTextFormField(
                    controller: vm.titleController,
                    hint: 'Learn Programming',
                    validator: (String? value) {
                      if (isResetForm) {
                        return null;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              Text(
                'Due Date',
                style: AppFonts.body14SB(),
              ),
              const SizedBox(height: 8),
              Selector<FormScreenViewModel, bool>(
                selector: (_, FormScreenViewModel vm) => vm.isResetForm,
                builder: (_, bool isResetForm, __) {
                  return CustomDateField(
                    controller: vm.dueDateController,
                    onDatePicked: vm.onDueDateChanged,
                    hint: 'March 06, 1998 12:00 PM',
                    currentTime: vm.dueDate,
                    validator: (String? value) {
                      if (isResetForm) {
                        return null;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please enter a due date';
                      }
                      return null;
                    },
                    suffix: const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.calendar_month,
                        color: Color(0xFFACB5BB),
                        size: 20,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Priority',
                style: AppFonts.body14SB(),
              ),
              CupertinoButton(
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
                    onSelectedItemChanged: vm.onPriorityChanged,
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
                    color: vm.priorityIndex == 0
                        ? Colors.red
                        : (vm.priorityIndex == 1 ? Colors.blue : Colors.grey),
                  ),
                ),
              ),
              const LineDivider(),
              const SizedBox(height: 15),
              _CheckList(parentContext: context),
            ],
          ),
        ),
      );
    });
  }
}

class _CheckList extends StatelessWidget {
  const _CheckList({
    required this.parentContext,
  });
  final BuildContext parentContext;

  void _showChecklistDialog(BuildContext context) {
    final FormScreenViewModel parentVM =
        parentContext.read<FormScreenViewModel>();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider<FormScreenViewModel>(
          create: (_) => FormScreenViewModel(),
          child: Consumer<FormScreenViewModel>(
            builder: (_, FormScreenViewModel vm, __) {
              final bool canContinue =
                  vm.checklistController.text.trim().isNotEmpty;

              return AlertDialog(
                backgroundColor: Colors.white,
                shadowColor: const Color(0xff222831),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: const Color(0xff222831).withValues(alpha: 0.5)),
                ),
                titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                title: Text(
                  'Add Checklist',
                  style: AppFonts.h3(),
                  textAlign: TextAlign.start,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const LineDivider(),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: vm.checklistController,
                      labelText: 'Add a checklist item',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a checklist item';
                        }
                        return null;
                      },
                    )
                  ],
                ),
                actions: [
                  AbsorbPointer(
                    absorbing: !canContinue,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        padding: const EdgeInsets.all(5),
                        backgroundColor:
                            canContinue ? Colors.orange : Colors.orange[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: canContinue
                          ? () {
                              Navigator.of(context).pop();
                              parentVM.addChecklistItem(
                                  vm.checklistController.text.trim());
                            }
                          : null,
                      child: Text(
                        'Add',
                        style: AppFonts.body12B(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.comfortable,
                      padding: const EdgeInsets.all(5),
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Close',
                      style: AppFonts.body12B(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormScreenViewModel>(
      builder: (_, FormScreenViewModel vm, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Checklist',
                  style: AppFonts.body14SB(),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _showChecklistDialog(context),
                  child: Icon(
                    CupertinoIcons.add_circled_solid,
                    color: Color(0xFF17563C),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            if (vm.checklistItems != null && vm.checklistItems!.isNotEmpty)
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.checklistItems!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (BuildContext context, int index) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 4, 0, 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          vm.checklistItems![index].title,
                          style: AppFonts.body12B(),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () =>
                            vm.removeChecklistItem(vm.checklistItems![index]),
                        icon: const Icon(
                          CupertinoIcons.delete_right_fill,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (vm.checklistItems != null && vm.checklistItems!.isNotEmpty)
              const SizedBox(height: 20),
            if (vm.checklistItems != null &&
                vm.checklistItems!.isNotEmpty &&
                vm.checklistItems!.length > 10)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Colors.white,
                      shadowColor: const Color(0xff222831),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color:
                                const Color(0xff222831).withValues(alpha: 0.5)),
                      ),
                      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      title: Text(
                        'Clear All Items',
                        style: AppFonts.h3(color: Colors.red),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Are you sure you want to clear all checklist items?',
                            style: AppFonts.body14SB(),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'This action cannot be undone.',
                            style: AppFonts.body14SB(),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            padding: const EdgeInsets.all(5),
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            vm.clearChecklist();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Yes',
                            style: AppFonts.body12B(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            padding: const EdgeInsets.all(5),
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'No',
                            style: AppFonts.body12B(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  size: 18,
                  CupertinoIcons.delete,
                  color: Colors.white,
                ),
                label: Text(
                  'Clear',
                  style: AppFonts.body12SB(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
