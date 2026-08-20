import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTitleCard extends StatelessWidget {
  const CardTitleCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 225, 225, 255),
      ),
    );
  }
}
