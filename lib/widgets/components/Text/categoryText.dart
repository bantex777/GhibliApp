import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.nunito(
        fontSize: 10.sp,
        color: const Color(0xFF817E73),
      ),
    );
  }
}
