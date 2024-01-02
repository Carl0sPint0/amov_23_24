import 'dart:collection';

import 'package:amov_23_24/screens/interest_points_screen.dart';
import 'package:amov_23_24/screens/last_int_points_screen.dart';
import 'package:amov_23_24/screens/locations_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/interest_point_display_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //_signInAnonymously();
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/locations/intPoints') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => InterestPointsScreen(queryKey: args),
          );
        }

        if (settings.name == '/locations/intPoints/intPointDisplay') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => InterestPointDisplayScreen(queryKey: args)
          );
        }

        if (settings.name == '/lastIntPoints') {
          final args = settings.arguments as HashMap<String, List<String>>;
          return MaterialPageRoute(
              builder: (context) => LastIntPointScreen(map: args)
          );
        }

        return null;
      },
      routes: {
        '/': (context) => const HomeScreen(),
        '/locations': (context) => LocationsScreen(),
      },
    );
  }
}