import 'package:flutter/material.dart';
class GitRepositoriesPage extends StatelessWidget {
  String login;
  GitRepositoriesPage({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Repositories $login'),),
      drawer: const Drawer(),
      body: const Center(
        child: Text('Repositories'),
      ),
    );
  }
}
