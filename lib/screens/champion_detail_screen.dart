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
    // Récupérer la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    // Définir un padding commun
    final EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.champion.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: commonPadding,
              child: Text("${widget.champion.name}", style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 10),
            // L'image n'a pas de padding pour utiliser toute la largeur de l'écran
            Image.asset(
              'assets/${widget.champion.iconPath}',
              width: screenWidth, // Utiliser la largeur de l'écran
              fit: BoxFit.cover, // Ajuster l'image pour remplir toute la largeur
            ),
            SizedBox(height: 10),
            Padding(
              padding: commonPadding,
              child: Text("${widget.champion.description}", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: commonPadding,
              child: Text("Sorts :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: commonPadding,
              child: buildSpellWidgets(),
            ),
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
