import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class GitRepositoriesPage extends StatefulWidget {

  String login;
  String avatarUrl;
  GitRepositoriesPage({super.key, required this.login,required this.avatarUrl});

  @override
  State<GitRepositoriesPage> createState() => _GitRepositoriesPageState();
}

class _GitRepositoriesPageState extends State<GitRepositoriesPage> {
  dynamic data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRepositories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Repositories ${widget.login}'),actions: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.avatarUrl),
        )
      ],),
      body:  Center(
        child: ListView.separated(
            itemBuilder: (context,index)=> ListTile(
              title: Text('${data[index]['name']}'),
            ),
            separatorBuilder: (context,index)=> const Divider(height: 2,color: Colors.indigo,),
            itemCount: data == null ? 0 : data.length)
      ),
    );
  }

  Future<void> _loadRepositories() async {
      Uri url = Uri.https('api.github.com','/users/${widget.login}/repos');
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        setState(() {
          data = jsonDecode(response.body);
        });
      }

  }
}
