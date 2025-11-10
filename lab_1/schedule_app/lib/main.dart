import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред за испити',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFE5B4),
          brightness: Brightness.light,
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Распоред за испити - 221225'),
        "/details": (context) => const DetailsPage(),
      },
    );
  }
}
