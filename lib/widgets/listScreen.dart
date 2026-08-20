// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/people/PeopleBloc.dart';
import 'package:studioghibli/data/repository/people/PeopleState.dart';
import 'package:studioghibli/core/contastants/constant.dart';
import 'package:studioghibli/widgets/components/Cards/mainCard.dart';
import 'package:studioghibli/widgets/components/Text/titleText.dart';
import 'package:studioghibli/widgets/infoScreen.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key, required this.category});

  final CategoryType category;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case CategoryType.films:
        return Scaffold(
          appBar: AppBar(
            title: TitleText(text: category.name.toUpperCase()),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: BlocBuilder<FilmBloc, FilmState>(
            builder: (context, state) {
              if (state.isLoading && state.films.isEmpty) {
                return SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Text(
                      'Shimmer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              if (state.error != null && state.films.isEmpty) {
                return Center(child: Text(state.error!));
              }

              return ListView.builder(
                itemCount: state.films.length,
                itemBuilder: (context, index) {
                  final film = state.films[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InfoScreen(id: film.id),
                        ),
                      );
                    },
                    child: MainCard(
                      title: film.title,
                      subText: film.description,
                      imagePath: film.image,
                    ),
                  );
                },
              );
            },
          ),
        );
      case CategoryType.people:
        return Scaffold(
          appBar: AppBar(title: TitleText(text: category.name.toUpperCase())),
          body: BlocBuilder<PeopleBloc, PeopleState>(
            builder: (context, state) {
              if (state is PeopleSuccess) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.people.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<PeopleBloc>(),
                                    child: InfoScreen(
                                      id: state.people[index].id,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: MainCard(
                              title: state.people[index].name,
                              subText: state.people[index].gender,
                              imagePath: state.people[index].url,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        );
      default:
        return SizedBox();
    }
  }
}
