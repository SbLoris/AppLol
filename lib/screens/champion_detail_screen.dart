import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/champion.dart';
import '../models/spell.dart';

class ChampionDetailScreen extends StatefulWidget {
  final Champion champion;

  const ChampionDetailScreen({super.key, required this.champion});

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
    const EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 16.0);

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
              child: Text(widget.champion.name, style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/${widget.champion.iconPath}',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10,),
            const Padding(padding: commonPadding,
            child: Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),

            const SizedBox(height: 20),
            Padding(
              padding: commonPadding,
              child: Text(widget.champion.description, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 2),  // Adds a visual divider
            const Padding(
              padding: commonPadding,
              child: Text("Capacités", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Section title for spells
            ),
            const SizedBox(height: 10),
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
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Erreur: ${snapshot.error}");
        } else {
          List<Spell>? spells = snapshot.data;
          return Column(
            children: spells != null && spells.isNotEmpty
                ? spells.map((spell) => ListTile(
              leading: Image.asset('assets/${spell.iconPath}', width: 50),
              title: Text(spell.name),
              subtitle: Text(spell.description),
            )).toList()
                : [const Text("Aucun sort disponible pour ce personnage", style: TextStyle(fontSize: 16))],
          );
        }
      },
    );
  }
}
