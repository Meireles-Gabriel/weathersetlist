import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weathersetlist/functions/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weathersetlist/utils/providers.dart';

Future<Weather> getWeather(String cityName) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=de27c79ce7595d929769313fcb788e38&units=metric'));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    return Weather(
      cityName: 'Failed to Load',
      temperature: 0.0,
      mainCondition: 'Clouds',
    );
  }
}

fetchWeatherBySearch(ref, cityName) async {
  ref.read(showingProvider.notifier).state = true;

  try {
    final weather = await getWeather(cityName);
    ref.read(weatherProvider.notifier).state = weather;
  } catch (e) {
    ref.read(weatherProvider.notifier).state = Weather(
      cityName: 'Failed to Load',
      temperature: 0.0,
      mainCondition: 'Clouds',
    );
  }
}

fetchWeatherByLocation(ref) async {
  ref.read(showingProvider.notifier).state = true;
  List data = await getCurrentCity();
  String cityName = data[0];

  try {
    final weather = await getWeather(cityName);
    ref.read(weatherProvider.notifier).state = weather;
  } catch (e) {
    ref.read(weatherProvider.notifier).state = Weather(
      cityName: 'Failed to Load',
      temperature: 0.0,
      mainCondition: 'Clouds',
    );
  }
}

Future<List<String>> getCurrentCity() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  final url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final address = jsonData['address'];
    final city = address['city'] ??
        address['town'] ??
        address['village'] ??
        address['country'] ??
        address['state'];
    return [city.toString(), address['country'].toString()];
  } else {
    return ['São Paulo', 'Brasil'];
  }
}
