import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    this.onSubmit,
    this.onChanged,
    this.onTap,
    required this.controller,
    this.hint,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.nextNode,
    this.validator,
    this.showClear = false,
    this.onClear,
    this.suffix,
    this.prefix,
    this.capitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.maxLength,
    this.textStyle,
    this.error,
    this.labelText,
    this.contentPadding,
    this.autofocus = false,
    this.borderWidth = 1,
    this.enableSuffixIcon = true,
    super.key,
  });

  final String? hint;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final FormFieldValidator<String?>? validator;
  final bool showClear;
  final Widget? suffix;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final VoidCallback? onSubmit;
  final TextCapitalization capitalization;
  final ValueChanged<String>? onFieldSubmitted;
  final int minLines;
  final int maxLines;
  final TextAlign textAlign;
  final bool enabled;
  final int? maxLength;
  final TextStyle? textStyle;
  final Widget? error;
  final String? labelText;
  final EdgeInsets? contentPadding;
  final bool autofocus;
  final double borderWidth;
  final bool enableSuffixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      onChanged: (String s) {
        if (widget.showClear) {
          setState(() {});
        }
        widget.onChanged?.call(s);
      },
      obscuringCharacter: '*',
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onTap: widget.onTap,
      controller: widget.controller,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.capitalization,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      cursorColor: Color(0xFF17563C),
      textAlign: widget.textAlign,
      style: widget.textStyle ??
          AppFonts.body14SB(),
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppFonts.body12R(),
        counterText: '',
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
        filled: true,
        prefixIcon: widget.prefix,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 12,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 12,
        ),
        hintText: widget.hint,
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
            width: widget.borderWidth,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFF17563C),
            width: widget.borderWidth,
          ),
        ),
        hintStyle: AppFonts.body14M(
          color: Color(0xFF17563C).withValues(alpha: .3),
        ),
      ),
      onEditingComplete: () {
        switch (widget.textInputAction) {
          case TextInputAction.next:
            FocusScope.of(context).requestFocus(widget.nextNode);
            break;
          case TextInputAction.done:
            FocusManager.instance.primaryFocus?.unfocus();
            widget.onSubmit?.call();
            break;
          case TextInputAction.none:
          case TextInputAction.go:
          case TextInputAction.search:
          case TextInputAction.send:
          case TextInputAction.previous:
          case TextInputAction.continueAction:
          case TextInputAction.join:
          case TextInputAction.route:
          case TextInputAction.unspecified:
          case TextInputAction.emergencyCall:
          case TextInputAction.newline:
            break;
        }
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
    );
  }
}
