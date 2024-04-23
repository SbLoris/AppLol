import 'package:flutter/material.dart';
import '../models/champion.dart';

class ChampionDetailScreen extends StatelessWidget {
  final Champion champion;

  ChampionDetailScreen({required this.champion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(champion.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name: ${champion.name}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Image.asset('assets/${champion.iconPath}'),
            SizedBox(height: 10),
            Text("Description: ${champion.description}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Spells:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...champion.spells!.map((spell) => ListTile(
              title: Text(spell.name),
              subtitle: Text(spell.description),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
