import 'package:bloc2/bloc/weather_bloc.dart';
import 'package:bloc2/data/weather_repository.dart';
import 'package:bloc2/pages/weather_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (BuildContext context) =>
              WeatherBloc(FakeWeatherRepository()),
          child: const WeatherSearchPage(),
        ));
  }
}
