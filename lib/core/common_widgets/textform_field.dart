import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;

  // Optional parameters
  final TextEditingController? controller;

  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? contentPadding;
  // final int hintMaxLine;
  final int? maxLines;
  // final bool showclearicon;
  const CustomTextFormField({
    super.key,
    required this.hintText,
  
    this.textDirection,
    this.readOnly = false,
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
    this.scrollPhysics,
    // this.hintMaxLine = 0,
    this.maxLines,
    this.contentPadding

    // this.showclearicon = false,
    
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      readOnly: readOnly,
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
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 02, vertical: 12),
      ),
      
    );
  }
}
