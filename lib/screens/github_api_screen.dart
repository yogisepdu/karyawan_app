import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubApiScreen extends StatefulWidget {
  @override
  _GitHubApiScreenState createState() => _GitHubApiScreenState();
}

class _GitHubApiScreenState extends State<GitHubApiScreen> {
  List<Map<String, dynamic>> _repos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchRepos();
  }

  Future<void> _fetchRepos() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/users/google/repos'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Map<String, dynamic>> repos = [];

      for (var item in data) {
        repos.add({
          'id': item['id'].toString(),
          'name': item['name'],
          'url': item['html_url'],
        });
      }

      setState(() {
        _repos = repos;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengambil data API')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub API - google/repos')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _repos.length,
              itemBuilder: (context, index) {
                final repo = _repos[index];
                return ListTile(
                  leading: Text(repo['id']),
                  title: Text(repo['name']),
                  subtitle: Text(repo['url']),
                );
              },
            ),
    );
  }
}
