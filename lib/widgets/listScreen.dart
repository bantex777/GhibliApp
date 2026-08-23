// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationBloc.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationState.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleBloc.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleState.dart';
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
                          builder: (_) => InfoScreen(
                            type: CategoryType.films.name,
                            id: film.id,
                          ),
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
              if (state.isLoading && state.people.isEmpty) {
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

              if (state.error != null && state.people.isEmpty) {
                return Center(child: Text(state.error!));
              }

              return ListView.builder(
                itemCount: state.people.length,
                itemBuilder: (context, index) {
                  final people = state.people[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InfoScreen(
                            type: CategoryType.people.name,
                            id: people.id,
                          ),
                        ),
                      );
                    },
                    child: MainCard(
                      title: people.name,
                      subText: people.gender,
                      imagePath: people.gender,
                    ),
                  );
                },
              );
            },
          ),
        );
      case CategoryType.locations:
        return Scaffold(
          appBar: AppBar(title: TitleText(text: category.name.toUpperCase())),
          body: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state.isLoading && state.locations.isEmpty) {
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

              if (state.error != null && state.locations.isEmpty) {
                return Center(child: Text(state.error!));
              }

              return ListView.builder(
                itemCount: state.locations.length,
                itemBuilder: (context, index) {
                  final location = state.locations[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InfoScreen(
                            type: CategoryType.locations.name,
                            id: location.id,
                          ),
                        ),
                      );
                    },
                    child: MainCard(
                      title: location.name,
                      subText: location.climate,
                      imagePath: location.climate,
                    ),
                  );
                },
              );
            },
          ),
        );
      default:
        return SizedBox();
    }
  }
}
