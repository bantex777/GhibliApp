import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSubText extends StatelessWidget {
  const CardSubText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.nunito(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
