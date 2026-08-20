import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubText extends StatelessWidget {
  const SubText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      
      style: GoogleFonts.nunito(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF64706D),
      ),
    );
  }
}
