import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathersetlist/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDhSRRqGvI1_UpMfMlA5BgGXJM7gK_VDNA",
          authDomain: "weathersetlist.firebaseapp.com",
          projectId: "weathersetlist",
          storageBucket: "weathersetlist.appspot.com",
          messagingSenderId: "976068634930",
          appId: "1:976068634930:web:9bc2d2d813984900490f2b"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PageStorageBucket bucket = PageStorageBucket();
    return ProviderScope(
      child: MaterialApp(
        title: 'Weather Setlist',
        debugShowCheckedModeBanner: false,
        home: PageStorage(
          bucket: bucket,
          child: const MainScreen(),
        ),
      ),
    );
  }
}
