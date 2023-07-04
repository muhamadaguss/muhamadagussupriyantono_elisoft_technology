import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_style.dart';
import 'reusable_text.dart';

import '../../constants/app_constants.dart';
import 'height_spacer.dart';

class ArticleHorizontal extends StatelessWidget {
  final String title;
  final String content;
  const ArticleHorizontal({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      width: width * .55,
      height: height * .27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Color(kGreen.value),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: title,
            style: appstyle(
              16,
              Color(kGreen.value),
              FontWeight.bold,
            ),
          ),
          const HeightSpacer(height: 5),
          Text(
            content,
            style: appstyle(
              16,
              Color(kDark.value),
              FontWeight.w400,
            ),
            maxLines: 7,
            overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }
}
