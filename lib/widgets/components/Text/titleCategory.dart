import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleCategory extends StatelessWidget {
  const TitleCategory({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.nunito(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF262D26),
      ),
    );
  }
}
