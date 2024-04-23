import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/champion.dart';
import '../models/spell.dart';

class ChampionDetailScreen extends StatefulWidget {
  final Champion champion;

  ChampionDetailScreen({required this.champion});

  @override
  _ChampionDetailScreenState createState() => _ChampionDetailScreenState();
}

class _ChampionDetailScreenState extends State<ChampionDetailScreen> {
  late Future<List<Spell>> futureSpells;

  @override
  void initState() {
    super.initState();
    futureSpells = ApiService().fetchChampionDetails(widget.champion.name, widget.champion)
        .then((champion) => champion.spells ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.champion.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name: ${widget.champion.name}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Image.asset('assets/${widget.champion.iconPath}', width: 700, height: 250, fit: BoxFit.fill,),
            SizedBox(height: 10),
            Text("Description: ${widget.champion.description}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Spells:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildSpellWidgets(),
          ],
        ),
      ),
    );
  }

  Widget buildSpellWidgets() {
    return FutureBuilder<List<Spell>>(
      future: futureSpells,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          List<Spell>? spells = snapshot.data;
          return Column(
            children: spells != null && spells.isNotEmpty
                ? spells.map((spell) => ListTile(
              leading: Image.asset('assets/${spell.iconPath}'),

              title: Text(spell.name),
              subtitle: Text(spell.description),
            )).toList()
                : [Text("No spells available for this champion.", style: TextStyle(fontSize: 16))],
          );
        }
      },
    );
  }

}
