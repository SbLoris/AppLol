import 'package:flutter/material.dart';
import 'api/api_service.dart';
import 'champion.dart';

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
      home: ChampionListScreen(),
    );
  }
}

class ChampionListScreen extends StatefulWidget {
  @override
  _ChampionListScreenState createState() => _ChampionListScreenState();
}

class _ChampionListScreenState extends State<ChampionListScreen> {
  late Future<List<Champion>> futureChampions;
  Champion? selectedChampion;

  @override
  void initState() {
    super.initState();
    futureChampions = ApiService().fetchChampions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Champion'),
      ),
      body: Center(
        child: FutureBuilder<List<Champion>>(
          future: futureChampions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            var champions = snapshot.data ?? [];
            return DropdownButton<Champion>(
              hint: Text("Select a champion"),
              value: selectedChampion,
              onChanged: (Champion? newValue) {
                setState(() {
                  selectedChampion = newValue;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChampionDetailScreen(champion: newValue!)),
                );
              },
              items: champions.map<DropdownMenuItem<Champion>>((Champion champion) {
                return DropdownMenuItem<Champion>(
                  value: champion,
                  child: Text(champion.champname),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class ChampionDetailScreen extends StatelessWidget {
  final Champion champion;

  ChampionDetailScreen({required this.champion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(champion.champname),
      ),
      body: SingleChildScrollView( // Utilisez SingleChildScrollView pour éviter les débordements
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name: ${champion.champname}", style: TextStyle(fontSize: 42)),
            SizedBox(height: 20), // Ajout d'un espace entre les éléments
            Image.network(champion.champicon), // Affiche l'icône du champion
            SizedBox(height: 20), // Ajout d'un espace entre les éléments
            Text("Description: ${champion.champdescription}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20), // Ajout d'un espace entre les éléments

          ],
        ),
      ),
    );
  }
}
