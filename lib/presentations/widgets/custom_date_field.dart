import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_date_picker.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({
    this.validator,
    this.onDatePicked,
    required this.controller,
    this.hint = 'mm/dd/yyyy hh:mm a',
    this.dateFormatDisplay = 'MMMM dd, yyyy hh:mm a',
    this.focusNode,
    this.nextNode,
    this.prefix,
    this.suffix,
    this.currentTime,
    this.maxTime,
    this.fillColor,
    this.margin,
    this.enabled = true,
    super.key,
  });

  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final String hint;
  final String dateFormatDisplay;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged<DateTime>? onDatePicked;
  final DateTime? currentTime;
  final DateTime? maxTime;
  final Color? fillColor;
  final EdgeInsets? margin;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onTap: () async => _showDatePicker(context),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      readOnly: true,
      focusNode: focusNode,
      cursorColor: Color(0xFF17563C),
      style: AppFonts.body14SB(),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 12,
        ),
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 12,
        ),
        hintText: hint,
        errorMaxLines: 3,
        errorStyle: AppFonts.body12R(
          color: Colors.red,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFF17563C),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFF17563C),
          ),
        ),
        hintStyle: AppFonts.body14M(
          color: Color(0xFF17563C).withValues(alpha: .3),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    DateTime? initialDateTime;
    DateTime currentDateTime = DateTime.now();
    if (currentTime == null || maxTime == null) {
      initialDateTime = currentDateTime;
    } else {
      if (currentTime!.isBefore(maxTime!)) {
        initialDateTime = currentTime;
      } else {
        initialDateTime = maxTime;
      }
    }
    await showCustomDatePicker(
      context: context,
      initialDateTime: initialDateTime!,
      onConfirm: (DateTime date) {
        controller.text = DateFormat(dateFormatDisplay).format(date);
        onDatePicked?.call(date);
        FocusScope.of(context).requestFocus(nextNode);
      },
      minimumDate: currentDateTime,
      specificPlatform: SpecificPlatform.ios,
    );
  }
}
