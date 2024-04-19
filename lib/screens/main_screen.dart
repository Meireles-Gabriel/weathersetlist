import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathersetlist/functions/weather_service.dart';
import 'package:weathersetlist/utils/app_colors.dart';
import 'package:weathersetlist/utils/providers.dart';
import 'package:weathersetlist/utils/responsive_model.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  labelText: 'Your city here...',
                  labelStyle:
                      GoogleFonts.montserrat().copyWith(color: Colors.white),
                ),
                style: GoogleFonts.montserrat().copyWith(color: Colors.white),
                maxLines: 1,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                fetchWeatherBySearch(ref, searchController.text);
              },
              child: Icon(
                Icons.search_rounded,
                color: AppColors.actionColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () {
                fetchWeatherByLocation(ref);
              },
              child: Icon(
                Icons.place_rounded,
                color: AppColors.actionColor,
              ),
            ),
          ],
        ),
      ),
      body: ResponsiveModel(
          mobile: Center(
              child: ref.watch(showingProvider)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ref.watch(weatherProvider).cityName,
                          style: const TextStyle(fontSize: 28),
                        ),
                        Text(ref.watch(weatherProvider).mainCondition,
                            style: const TextStyle(fontSize: 28)),
                        Text(
                            '${ref.watch(weatherProvider).temperature.round()}ºC',
                            style: const TextStyle(fontSize: 28)),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width - 100,
                          child: Image.asset('/textlogo.png'),
                        ),
                        SizedBox(
                          width: size.width - 100,
                          child: Text(
                            'Search your city above or activate geolocation to find recommendations for playlists that match the current weather.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(),
                          ),
                        )
                      ],
                    )),
          tablet: const Placeholder(),
          desktop: const Placeholder(),
          paddingWidth: size.width * 0.2,
          bgColor: Colors.grey),
    );
  }
}
