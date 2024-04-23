import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/champion.dart';
import '../models/spell.dart';

class ApiService {
  // Fetch details for a single champion
  Future<Champion> fetchChampionDetails(String name) async {
    final response = await http.get(Uri.parse('https://applimobilelol.yannick-comba.mds-angers.yt/champions/$name'));
    if (response.statusCode == 200) {
      // Decode the JSON response as a list
      List<dynamic> jsonResponse = json.decode(response.body);
      // Check if the list is not empty
      if (jsonResponse.isNotEmpty) {
        // Get the first item in the list and convert it to a Champion object
        return Champion.fromJson(jsonResponse[0]);
      } else {
        throw Exception('No champion data available for $name');
      }
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
