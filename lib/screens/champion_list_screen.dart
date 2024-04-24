import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/champion.dart';
import 'champion_detail_screen.dart';

class ChampionListScreen extends StatefulWidget {
  const ChampionListScreen({super.key});

  @override
  _ChampionListScreenState createState() => _ChampionListScreenState();
}

class _ChampionListScreenState extends State<ChampionListScreen> {
  late Future<List<Champion>> futureChampions;

  @override
  void initState() {
    super.initState();
    futureChampions = ApiService().fetchChampions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Champion'),
      ),
      body: Center(
        child: FutureBuilder<List<Champion>>(
          future: futureChampions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            var champions = snapshot.data ?? [];
            return ListView.builder(
              itemCount: champions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(champions[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChampionDetailScreen(champion: champions[index]),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
