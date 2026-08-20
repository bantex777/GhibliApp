import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studioghibli/widgets/components/Text/categoryText.dart';
import 'package:studioghibli/widgets/components/Text/titleCategory.dart';

class ThumbnailCard extends StatelessWidget {
  const ThumbnailCard({
    super.key,
    this.title = '',
    this.subText = '',
    this.imagePath = '',
  });

  final String title;
  final String subText;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E0D6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleCategory(title: title),
                  InfoText(text: subText),
                ],
              ),
            ),
            Image.asset(imagePath, width: 50.w, height: 50.h, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
