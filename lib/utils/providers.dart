import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathersetlist/functions/weather_model.dart';

final cityNameProvider = StateProvider<String>((ref) => '');
final countryNameProvider = StateProvider<String>((ref) => '');
final weatherProvider = StateProvider<Weather>((ref) =>
    Weather(cityName: 'São Paulo', temperature: 0, mainCondition: 'Clouds'));
final showingProvider = StateProvider<bool>((ref) => false);