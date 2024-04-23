import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/champion.dart';
import '../models/spell.dart';

class ApiService {
  Future<Champion> fetchChampionDetails(String name, Champion champion) async {
    final response = await http.get(Uri.parse('https://applimobilelol.yannick-comba.mds-angers.yt/champions/$name'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      // Filter spells for the specific champion
      List<dynamic> spellsJson = jsonResponse.where((data) => data['champions_id'] == champion.id.toString()).toList();
      // Convert spells to List<Spell>
      List<Spell> spells = spellsJson.map((data) => Spell.fromJson(data)).toList();
      // Assign spells to the champion
      champion.spells = spells;
      return champion;
    } else {
      throw Exception('Failed to load champion details for $name');
    }
  }




  // Fetch the list of all champions
  Future<List<Champion>> fetchChampions() async {
    final response = await http.get(Uri.parse('https://applimobilelol.yannick-comba.mds-angers.yt/champions'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      // Convert each item in the list to a Champion object
      return jsonResponse.map((data) => Champion.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load champions');
    }
  }
}
