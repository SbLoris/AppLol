import 'package:flutter/material.dart';
import 'screens/champion_list_screen.dart';  // Import the ChampionListScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League of Legends Champions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChampionListScreen(),  // Home is set to ChampionListScreen
    );
  }
}
