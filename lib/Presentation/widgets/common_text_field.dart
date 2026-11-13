import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';

/// Outlined text field that shows [errorText] in red below it and turns its border red.
class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int minLines;
  final int maxLines;
  final double? fontSize;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final IconData? prefixIcon;

  const CommonTextField({
    super.key,
    required this.controller,
    this.hint,
    this.errorText,
    this.onChanged,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.fontSize,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).highlightColor;
    final red = AppColor.red(context);
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.h_4),
      borderSide: BorderSide(color: color, width: width),
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: TextStyle(fontSize: fontSize ?? FontSize.sp_11, color: textColor, height: 1.3),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: FontSize.sp_11, color: Theme.of(context).hintColor),
        hintMaxLines: 3,
        errorText: errorText,
        errorMaxLines: 3,
        errorStyle: TextStyle(fontSize: FontSize.sp_10, color: red, fontWeight: FontWeight.w500),
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, size: Dimensions.h_15),
        contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_6),
        counterStyle: TextStyle(fontSize: FontSize.sp_9, color: Theme.of(context).hintColor),
        border: border(textColor, 0.1),
        enabledBorder: border(textColor, 0.1),
        focusedBorder: border(textColor, 0.1),
        errorBorder: border(red, 0.5),
        focusedErrorBorder: border(red, 0.5),
      ),
    );
  }
}
