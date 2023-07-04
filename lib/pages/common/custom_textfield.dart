import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_constants.dart';
import 'app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.keyboardType,
      this.validator,
      this.suffixIcon,
      this.obscureText});

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        fillColor: Color(kLightGreen.value),
        filled: true,
        labelText: labelText,
        labelStyle: appstyle(16, Color(kGreen.value), FontWeight.bold),
        suffixIcon: suffixIcon,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        errorMaxLines: 5,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Color(kLightGreen.value),
            width: 0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Color(kLightGreen.value),
            width: 0,
          ),
        ),
        border: InputBorder.none,
      ),
      controller: controller,
      cursorHeight: 20,
      style: appstyle(
        16,
        Color(kDark.value),
        FontWeight.w500,
      ),
      validator: validator,
    );
  }
}
