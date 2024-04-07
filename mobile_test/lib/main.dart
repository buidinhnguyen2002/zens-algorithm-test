import 'package:flutter/material.dart';
import 'package:mobile_test/screens/home_screen.dart';
import 'package:mobile_test/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: lightMode,
      home: const HomeScreen(),
    );
  }
}
