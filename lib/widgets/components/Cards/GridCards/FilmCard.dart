import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/widgets/components/Text/cardSubText.dart';
import 'package:studioghibli/widgets/components/Text/cardTitleText.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({super.key, required this.title, required this.imagePath});

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, state) {
        if (state is FilmFailure) {
          print(state.message);
        }

        final count = state.films.length;

        return Container(
          height: 130.h,
          margin: EdgeInsets.all(4.w),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(imagePath, fit: BoxFit.cover),

              // Dark overlay
              Container(color: Colors.black.withValues(alpha: 0.30)),

              // Content
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CardTitleCard(text: title),
                    CardSubText(text: '${count.toString()} Entries'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
