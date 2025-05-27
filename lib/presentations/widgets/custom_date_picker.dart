import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SpecificPlatform {
  ios,
  android,
}

Future<void> showCustomDatePicker({
  required BuildContext context,
  required ValueChanged<DateTime> onConfirm,
  required DateTime initialDateTime,
  DateTime? minimumDate,
  bool isDismissible = true,
  SpecificPlatform? specificPlatform,
}) async {
  Future<void> ios() async => showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: isDismissible,
        builder: (_) => DatePickerBottomSheet(
          onConfirm: onConfirm,
          initialDateTime: initialDateTime,
          minimumDate: minimumDate ?? DateTime.now(),
        ),
      );

  await ios();
}

class DatePickerBottomSheet extends StatefulWidget {
  const DatePickerBottomSheet({
    required this.onConfirm,
    required this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    super.key,
  });

  final ValueChanged<DateTime> onConfirm;
  final DateTime initialDateTime;
  final DateTime? maximumDate;
  final DateTime? minimumDate;

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    DateTime chosenDate = widget.initialDateTime;

    return Container(
      height: MediaQuery.of(context).size.height / 2.25,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text('Cancel', style: AppFonts.body16B()),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'Confirm',
                  style: AppFonts.body16B(),
                ),
                onPressed: () {
                  widget.onConfirm(chosenDate);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: (DateTime date) => chosenDate = date,
              initialDateTime: widget.initialDateTime,
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        ],
      ),
    );
  }
}
