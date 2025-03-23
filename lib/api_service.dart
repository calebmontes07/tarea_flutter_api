import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:premier_league_app/models/team.dart';

Future<List<String>> fetchAllTeams() async {
  final response = await http.get(
    Uri.parse('https://heisenbug-premier-league-live-scores-v1.p.rapidapi.com/api/premierleague/teams'),
    headers: {
      'x-rapidapi-key': 'tu-api-key',
      'x-rapidapi-host': 'heisenbug-premier-league-live-scores-v1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((team) => team['name'] as String).toList(); 
  } else {
    throw Exception('Failed to load teams');
  }
}


Future<Team> fetchTeam(String teamName) async {
  final response = await http.get(
    Uri.parse('https://heisenbug-premier-league-live-scores-v1.p.rapidapi.com/api/premierleague/team?name=$teamName'),
    headers: {
      'x-rapidapi-key': 'tu-api-key', 
      'x-rapidapi-host': 'heisenbug-premier-league-live-scores-v1.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
  
    return Team.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load team');
  }
}
