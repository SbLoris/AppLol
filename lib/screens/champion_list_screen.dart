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
        backgroundColor: Colors.black26, // Modern color for the AppBar
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
                return Card(
                  elevation: 5, // Adds shadow under each list item
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text(champions[index].name, style: TextStyle(color: Colors.black)), // Stylish text
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50), // Circular image
                      child: Image.asset(
                        'assets/${champions[index].iconPath}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChampionDetailScreen(champion: champions[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
