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
    final EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.champion.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Nom : ${widget.champion.name}", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            // Text("Roles : ${widget.champion.roles}", style: const TextStyle(fontSize: 24)),
            // const SizedBox(height: 10),
            // Text("Types : ${widget.champion.types}", style: const TextStyle(fontSize: 24)),
            // const SizedBox(height: 10),
            Image.asset('assets/${widget.champion.iconPath}', width: 700, height: 250, fit: BoxFit.fill,),
            const SizedBox(height: 10),
            Text("Description: ${widget.champion.description}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Spells:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          return const CircularProgressIndicator();
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
                : [const Text("No spells available for this champion.", style: TextStyle(fontSize: 16))],
          );
        }
      },
    );
  }

}
