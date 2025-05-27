import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;

  // Optional parameters
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  // final int hintMaxLine;
  final int? maxLines;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.style,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.onChanged,
    this.onSaved,
    this.validator,
    // this.hintMaxLine = 0,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
      
        hintText: hintText,
      
        // hintMaxLines: hintMaxLine,
        maintainHintHeight: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border ?? InputBorder.none,
        focusedBorder: focusedBorder ?? InputBorder.none,
        enabledBorder: enabledBorder ?? InputBorder.none,
      ),
    );
  }
}
