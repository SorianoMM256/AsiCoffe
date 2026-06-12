import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const AsiCoffeeApp());
}

class AsiCoffeeApp extends StatelessWidget {
  const AsiCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsiCoffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF795548),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}