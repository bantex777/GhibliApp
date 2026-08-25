import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studioghibli/core/contastants/constant.dart' show CategoryType;
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmEvent.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationBloc.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationEvent.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationState.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleBloc.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleEvent.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleState.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesBloc.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesEvent.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesState.dart';
import 'package:studioghibli/data/repository/species/use_case/Get_SpeciesDetails.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CarBloc.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CarState.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CardEvent.dart';
import 'package:studioghibli/data/repository/vehicles/use_case/Get_Car_Details.dart';
import 'package:studioghibli/widgets/components/Text/subtText.dart';
import 'package:studioghibli/widgets/components/Text/titleText.dart';

class InfoScreen extends StatefulWidget {
  final String id;
  final String type;
  const InfoScreen({super.key, required this.id, required this.type});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.type == CategoryType.films.name) {
      context.read<FilmBloc>().add(LoadFilm(widget.id));
    } else if (widget.type == CategoryType.people.name) {
      context.read<PeopleBloc>().add(LoadPerson(widget.id));
    } else if (widget.type == CategoryType.locations.name) {
      context.read<LocationBloc>().add(GetLocationDetails(widget.id));
    } else if (widget.type == CategoryType.species.name) {
      context.read<SpeciesBloc>().add(LoadSpeciesDetails(widget.id));
    } else if (widget.type == CategoryType.cars.name) {
      context.read<CarBloc>().add(LoadCarDetails(widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == CategoryType.films.name) {
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
                            SizedBox(height: 2.h),
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                physics: PageScrollPhysics(),
                                itemCount: filmDetail.people.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    margin: EdgeInsets.all(6),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFFF6F1ED),
                                      ),
                                    ),
                                    child: SubText(
                                      text: filmDetail.people[index].name,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 5.w),
                                SubText(text: 'Key Locations'),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                physics: PageScrollPhysics(),
                                itemCount: filmDetail.locations.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    margin: EdgeInsets.all(6),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFFF6F1ED),
                                      ),
                                    ),
                                    child: SubText(
                                      text: filmDetail.locations[index].name,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 5.w),
                                SubText(text: 'Species / Creatures'),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                physics: PageScrollPhysics(),
                                itemCount: filmDetail.species.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    margin: EdgeInsets.all(6),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFFF6F1ED),
                                      ),
                                    ),
                                    child: SubText(
                                      text: filmDetail.species[index].name,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 5.w),
                                SubText(text: 'Feature Vehicles'),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                physics: PageScrollPhysics(),
                                itemCount: filmDetail.vehicles.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    margin: EdgeInsets.all(6),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFFF6F1ED),
                                      ),
                                    ),
                                    child: SubText(
                                      text: filmDetail.vehicles[index].name,
                                    ),
                                  );
                                },
                              ),
                            ),
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
    } else if (widget.type == CategoryType.people.name) {
      return BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          if (state.isLoading && state.personDetails == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.personDetails == null) {
            return Scaffold(body: Center(child: Text(state.error!)));
          }

          final personDetails = state.personDetails;

          if (personDetails != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Person Details'),
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
                        Image.asset(
                          'assets/images/img1.png',
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 6),
                        Center(
                          child: TitleText(text: personDetails.person.name),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            SubText(text: 'Age: ${personDetails.person.age}'),
                            SizedBox(width: 10),
                            Icon(Icons.remove_red_eye),
                            SubText(
                              text:
                                  'Eye Color ${personDetails.person.eyeColor} ',
                            ),
                            SizedBox(width: 10),

                            Icon(Icons.star),
                            SubText(
                              text: '${personDetails.films.first}% Match',
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        SubText(text: 'DIRECTOR & STUDIO'),
                        SubText(
                          text: '* Directed by: ${personDetails.species!.name}',
                        ),
                        SubText(
                          text: '* Produced by: ${personDetails.person.gender}',
                        ),
                        SizedBox(height: 6),
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
    } else if (widget.type == CategoryType.locations.name) {
      return BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.isLoading && state.locationDetails == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.locationDetails == null) {
            return Scaffold(body: Center(child: Text(state.error!)));
          }

          final personDetails = state.locationDetails;

          if (personDetails != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Person Details'),
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
                        Image.asset(
                          'assets/images/img1.png',
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 6),
                        Center(
                          child: TitleText(text: personDetails.location.name),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            SubText(
                              text: 'Age: ${personDetails.location.climate}',
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.remove_red_eye),
                            SubText(
                              text: 'Eye Color ${personDetails.location.name} ',
                            ),
                            SizedBox(width: 10),

                            Icon(Icons.star),
                            SubText(
                              text: '${personDetails.films.first}% Match',
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        SubText(text: 'DIRECTOR & STUDIO'),
                        SubText(
                          text: '* Directed by: ${personDetails.location.name}',
                        ),
                        SubText(
                          text:
                              '* Produced by: ${personDetails.location.films.length}',
                        ),
                        SizedBox(height: 6),
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
    } else if (widget.type == CategoryType.species.name) {
      return BlocBuilder<SpeciesBloc, SpeciesState>(
        builder: (context, state) {
          if (state.isLoading && state.speciesDetails == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.speciesDetails == null) {
            return Scaffold(body: Center(child: Text(state.error!)));
          }

          final speciesDetails = state.speciesDetails;

          if (speciesDetails != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Person Details'),
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
                        Image.asset(
                          'assets/images/img1.png',
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 6),
                        Center(
                          child: TitleText(text: speciesDetails.species.name),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            SubText(
                              text:
                                  'Age: ${speciesDetails.species.classification}',
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.remove_red_eye),
                            SubText(
                              text:
                                  'Eye Color ${speciesDetails.species.eyeColors} ',
                            ),
                            SizedBox(width: 10),

                            Icon(Icons.star),
                            SubText(
                              text: '${speciesDetails.films.first}% Match',
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        SubText(text: 'DIRECTOR & STUDIO'),
                        SubText(
                          text: '* Directed by: ${speciesDetails.species.name}',
                        ),
                        SubText(
                          text:
                              '* Produced by: ${speciesDetails.species.films.length}',
                        ),
                        SizedBox(height: 6),
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
    } else if (widget.type == CategoryType.cars.name) {
      return BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state.isLoading && state.carDetails == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.carDetails == null) {
            return Scaffold(body: Center(child: Text(state.error!)));
          }

          final carDetails = state.carDetails;

          if (carDetails != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Person Details'),
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
                        Image.asset(
                          'assets/images/img1.png',
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 6),
                        Center(child: TitleText(text: carDetails.car.name)),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            SubText(text: 'Age: ${carDetails.car.description}'),
                            SizedBox(width: 10),
                            Icon(Icons.remove_red_eye),
                            SubText(text: 'Eye Color ${carDetails.car.pilot} '),
                            SizedBox(width: 10),

                            Icon(Icons.star),
                            SubText(text: '${carDetails.car.length}% Match'),
                          ],
                        ),
                        SizedBox(height: 6),
                        SubText(text: 'DIRECTOR & STUDIO'),
                        SubText(
                          text: '* Directed by: ${carDetails.car.vehicleClass}',
                        ),
                        SubText(
                          text: '* Produced by: ${carDetails.car.films.length}',
                        ),
                        SizedBox(height: 6),
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

    return SizedBox();
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
