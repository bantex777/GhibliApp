import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studioghibli/controller/loadMenu.dart';
import 'package:studioghibli/core/di/injection.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmEvent.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/location/LocationBloc.dart';
import 'package:studioghibli/data/repository/location/LocationEvent.dart';
import 'package:studioghibli/data/repository/people/PeopleBloc.dart';
import 'package:studioghibli/data/repository/people/PeopleEvent.dart';
import 'package:studioghibli/data/repository/species/SpeciesBloc.dart';
import 'package:studioghibli/data/repository/species/SpeciesEvent.dart';
import 'package:studioghibli/data/repository/vehicles/CarBloc.dart';
import 'package:studioghibli/data/repository/vehicles/CardEvent.dart';
import 'package:studioghibli/core/contastants/constant.dart';
import 'package:studioghibli/widgets/components/Cards/GridCards/FilmCard.dart';
import 'package:studioghibli/widgets/components/Cards/GridCards/LocationCard.dart';
import 'package:studioghibli/widgets/components/Cards/GridCards/PeopleCard.dart';
import 'package:studioghibli/widgets/components/Cards/GridCards/SpeciesCard.dart';
import 'package:studioghibli/widgets/components/Cards/GridCards/VehicleCard.dart';
import 'package:studioghibli/widgets/components/Cards/mainCard.dart';
import 'package:studioghibli/widgets/components/Inputs/inputText.dart'
    show InputText;
import 'package:studioghibli/widgets/components/Text/subtText.dart';
import 'package:studioghibli/widgets/components/Text/titleText.dart';
import 'package:studioghibli/widgets/components/bottomNavigationBar.dart';
import 'package:studioghibli/widgets/listScreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<FilmBloc>()..add(LoadFilms()),
        ),
        BlocProvider(
          create: (context) => locator<PeopleBloc>()..add(LoadPeople()),
        ),
        BlocProvider(
          create: (context) => locator<LocationBloc>()..add(LoadLocation()),
        ),
        BlocProvider(
          create: (context) => locator<SpeciesBloc>()..add(LoadSpecies()),
        ),
        BlocProvider(create: (context) => locator<CarBloc>()..add(LoadCars())),
      ],
      child: Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(currentIndex: 0),
        body: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (ctx) => SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        // Header
                        Row(
                          children: [
                            SizedBox(width: 4.w),
                            Icon(Icons.energy_savings_leaf),
                            SizedBox(
                              height: 60.h,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(2, 16, 16, 0),
                                child: TitleText(text: 'Ghibli Dex'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: SubText(
                              text: 'The earth speaks to those who listen....',
                            ),
                          ),
                        ),
                        // Search bar
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          width: double.infinity,
                          height: 50.h,
                          child: InputText(
                            hintText: 'Search films, characters, places...',
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: SubText(text: 'EXPLORE CATEGORIES'),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder(
                          future: LoadMenu(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (EditableText.debugDeterministicCursor) {
                              return const Center(
                                child: Text('Error loading data'),
                              );
                            }

                            final menuData = asyncSnapshot.data;
                            return GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4.h,
                                    crossAxisSpacing: 4.w,
                                    childAspectRatio: 1.5,
                                  ),
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ListScreen(
                                          category: CategoryType.films,
                                        ),
                                      ),
                                    );
                                  },
                                  child: FilmCard(
                                    title: menuData![0].title,
                                    imagePath: menuData[0].imageUrl,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<PeopleBloc>(),
                                          child: ListScreen(
                                            category: CategoryType.people,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: PeopleCard(
                                    title: menuData[1].title,
                                    imagePath: menuData[1].imageUrl,
                                  ),
                                ),
                                LocationCard(
                                  title: menuData[2].title,
                                  imagePath: menuData[2].imageUrl,
                                ),
                                SpeciesCard(
                                  title: menuData[3].title,
                                  imagePath: menuData[3].imageUrl,
                                ),
                                CarCard(
                                  title: menuData[4].title,
                                  imagePath: menuData[4].imageUrl,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: SubText(text: 'FEATURED CARD'),
                        ),
                        SizedBox(height: 10),

                        BlocBuilder<FilmBloc, FilmState>(
                          builder: (context, state) {
                            print(
                              'FILM STATE: '
                              'films=${state.films.length}, '
                              'details=${state.filmDetails != null}, '
                              'loading=${state.isLoading}, '
                              'error=${state.error}',
                            );

                            if (state.isLoading && state.films.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (state.error != null && state.films.isEmpty) {
                              return Center(child: Text(state.error!));
                            }

                            if (state.films.isNotEmpty) {
                              final featureFilm = Random().nextInt(
                                state.films.length,
                              );

                              return MainCard(
                                title: state.films[featureFilm].title,
                                subText: state.films[featureFilm].description,
                                imagePath: state.films[featureFilm].image,
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
