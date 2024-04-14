import 'package:flutter/material.dart';
import 'package:weathersetlist/functions/weather_model.dart';
import 'package:weathersetlist/functions/weather_service.dart';
import 'package:weathersetlist/utils/responsive_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _weatherService = WeatherService('de27c79ce7595d929769313fcb788e38');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: ResponsiveModel(
          mobile: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weather?.cityName ?? 'Loading City...',
                  style: const TextStyle(fontSize: 28),
                ),
                Text(_weather?.mainCondition ?? '', style: const TextStyle(fontSize: 28)),
                Text('${_weather?.temperature.round()}ºC', style: const TextStyle(fontSize: 28)),
              ],
            ),
          ),
          tablet: const Placeholder(),
          desktop: const Placeholder(),
          paddingWidth: size.width * 0.2,
          bgColor: Colors.lightBlue),
    );
  }
}
