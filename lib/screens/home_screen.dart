import 'package:flutter/material.dart';
import '../api_service.dart';  
import '../models/team.dart'; 

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _teamName = "";
  Future<List<String>>? teamListFuture; 
  Future<Team>? teamFuture;

  @override
  void initState() {
    super.initState();
    teamListFuture = fetchAllTeams(); 
  }

 
  void _fetchTeamData(String teamName) {
    setState(() {
      _teamName = teamName;
      teamFuture = fetchTeam(teamName); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Premier League Team Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<List<String>>(
              future: teamListFuture, 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final teams = snapshot.data!;
                  return Column(
                    children: [
                      DropdownButton<String>(
                        hint: Text('Select a team'),
                        value: _teamName.isEmpty ? null : _teamName,
                        onChanged: (newTeamName) {
                          if (newTeamName != null) {
                            _fetchTeamData(newTeamName); 
                          }
                        },
                        items: teams.map((team) {
                          return DropdownMenuItem<String>(
                            value: team,
                            child: Text(team),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('No teams found'));
                }
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<Team>(
                future: teamFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final team = snapshot.data!;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(team.logo), 
                          Text('Name: ${team.name}', style: TextStyle(fontSize: 24)),
                          Text('Position: ${team.position}', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text('No data found for the team'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



