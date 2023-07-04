import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../constants/app_constants.dart';
import 'common.dart';

class ArticleVertical extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final String image;
  const ArticleVertical({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Color(
          kLightGreen.value,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    image,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
                const WidthSpacer(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: appstyle(
                      16,
                      Color(kDark.value),
                      FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(height: 15),
            Text(
              content,
              style: appstyle(
                16,
                Color(kDark.value),
                FontWeight.w500,
              ),
            ),
            const HeightSpacer(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat('dd MMMM yyyy hh:mm:ss', 'id_ID').format(
                  DateTime.parse(date),
                ),
                style: appstyle(
                  16,
                  Color(kDark.value),
                  FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
