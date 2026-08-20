import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmEvent.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/widgets/components/Text/subtText.dart';
import 'package:studioghibli/widgets/components/Text/titleText.dart';

class InfoScreen extends StatefulWidget {
  final String id;
  const InfoScreen({super.key, required this.id});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<FilmBloc>().add(LoadFilm(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, state) {
        if (state.isLoading && state.filmDetails == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.filmDetails == null) {
          return Scaffold(body: Center(child: Text(state.error!)));
        }

        final filmDetail = state.filmDetails;

        if (filmDetail != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Film Details'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        filmDetail.film.image,
                        width: double.infinity,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 6),
                      Center(child: TitleText(text: filmDetail.film.title)),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SubText(text: filmDetail.film.releaseDate),
                          SizedBox(width: 10),
                          Icon(Icons.punch_clock),
                          SubText(text: '${filmDetail.film.runningTime} min'),
                          SizedBox(width: 10),

                          Icon(Icons.star),
                          SubText(text: '${filmDetail.film.rtScore}% Match'),
                        ],
                      ),
                      SizedBox(height: 6),
                      SubText(text: 'DIRECTOR & STUDIO'),
                      SubText(
                        text: '* Directed by: ${filmDetail.film.director}',
                      ),
                      SubText(
                        text: '* Produced by: ${filmDetail.film.producer}',
                      ),
                      SizedBox(height: 6),
                      SubText(text: 'SYNOPSIS'),
                      Text(filmDetail.film.description),
                      SizedBox(height: 12),
                      SubText(text: 'RELATIONSHIPS & TAGGED ENTRIES'),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people),
                              SizedBox(width: 5.w),
                              SubText(text: 'Key People / Characters'),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filmDetail.people.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFFF6F1ED),
                                  ),
                                ),
                                child: Text(filmDetail.people[index].name),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 5.w),
                          SubText(text: 'Key Locations'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 5.w),
                          SubText(text: 'Species / Creatures'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 5.w),
                          SubText(text: 'Feature Vehicles'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
