import 'package:http/http.dart' as http;
import 'dart:convert';
import '../champion.dart';

class ApiService {
  Future<List<Champion>> fetchChampions() async {
    final response = await http.get(Uri.parse(
        'https://applimobilelol.yannick-comba.mds-angers.yt/champions'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Champion.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load champions');
    }
  }
}
