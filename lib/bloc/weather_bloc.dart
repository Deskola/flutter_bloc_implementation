import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc2/data/model/weather.dart';
import 'package:bloc2/data/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherEvent>(_onLoadWeatherEvent);
    on<GetWeather>(_onGetWeatherEvent);
    on<GetDetailedWeather>(_onGetWeatherDetailsEvent);
  }

  FutureOr<void> _onLoadWeatherEvent(
      WeatherEvent event, Emitter<WeatherState> emit) {
    emit(const WeatherLoading());
  }

  Future<FutureOr<void>> _onGetWeatherEvent(
      GetWeather event, Emitter<WeatherState> emit) async {
    try {
      final weather = await weatherRepository.fetchWeather(event.cityName);
      emit(WeatherLoaded(weather));
    } on NetworkError {
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }

  Future<FutureOr<void>> _onGetWeatherDetailsEvent(
      GetDetailedWeather event, Emitter<WeatherState> emit) async {
    try {
      final weather =
          await weatherRepository.fetchDetailedWeather(event.cityName);
      emit(WeatherLoaded(weather));
    } on NetworkError {
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
