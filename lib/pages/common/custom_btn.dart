import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_style.dart';
import 'reusable_text.dart';
import '../../../constants/app_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.onTap,
  });

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(
              kGreen.value,
            ),
          ),
          width: width,
          height: height * 0.075,
          child: Center(
            child: ReusableText(
              text: text,
              style: appstyle(
                16,
                color ?? Color(kLight.value),
                FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
