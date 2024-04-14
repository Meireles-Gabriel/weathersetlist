import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weathersetlist/functions/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
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
      // Ajuste a estrutura do endereço conforme necessário
      final city = address['city'] ??
          address['town'] ??
          address['village'] ??
          address['county'] ??
          address['state'];
      return city.toString();
    } else {
      throw Exception('Failed to load city name');
    }
  }
}
