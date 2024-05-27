import 'package:flutter/material.dart';
import 'package:superhero_mobile_flutter/screens/hero_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:HeroListScreen()
    );
  }
}