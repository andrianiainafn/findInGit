import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:git_api/pages/repositories/repositories.page.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String? _query;
  bool _isvisible= false;
  dynamic data;
  int _currentPage =0;
  int totalPage = 0;
  int pageSize = 20;
  ScrollController scrollController = ScrollController();
  List<dynamic> _items = [];
  TextEditingController queryTextEditingController = TextEditingController();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        setState(() {
          if(_currentPage < (totalPage - 1) ){
            _currentPage += 1;
            _search(_query);
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('User $_query => ${_currentPage}  / $totalPage'),),
      body:  Center(
        child: Column(
          children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: _isvisible,
                          onChanged: (value){
                            setState(() {
                              _query = value;
                              // _search(_query);
                            });
                          },
                          controller: queryTextEditingController,
                          decoration:  InputDecoration(
                            // icon: const Icon(Icons.person),
                              suffixIcon: IconButton(onPressed: () {
                                setState(() {
                                  _isvisible = !_isvisible;
                                });

                              }, icon:   Icon( _isvisible ? Icons.visibility_off : Icons.visibility ),),
                              contentPadding: const EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.indigo
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        )),
                  ),
                  IconButton(onPressed: () async {
                    // this._query = queryTextEditingController.text;
                    //   await _search(_query);
                    setState(() {
                      _items = [];
                      _currentPage = 0;
                      print(queryTextEditingController.text);
                      _query = queryTextEditingController.text;
                      _search(_query);
                    });
                  }, icon: const Icon(Icons.search,color: Colors.indigo,))
                ],
              ),
            Expanded(
              child: ListView.separated(
                  separatorBuilder:(context,index) =>  const Divider (height: 2, color: Colors.indigo),
                  controller: scrollController,
                  itemCount: _items.length,itemBuilder: (context,index){
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GitRepositoriesPage(login: _items[index]['login'],avatarUrl: _items[index]['avatar_url']) ));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage( _items[index]['avatar_url'] ),
                          ),
                          const SizedBox(width: 15),
                          Text("${_items[index]['login']} "),

                        ],
                      ),
                      CircleAvatar(
                        radius: 15,
                        child: Text('${_items[index]['score']}'),
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        )
      ),
    );
  }
  //
  Future<void> _search(String? query) async {
    Uri url = Uri.https('api.github.com', '/search/users', {'q': query, 'per_page': '$pageSize', 'page': '$_currentPage'});
    print(url);
   var response = await http.get(url);
   print(response.body);
   setState(() {
     data =json.decode(response.body);
     _items.addAll(data['items']);
     if(data['total_count'] % pageSize == 0 ){
      totalPage = data['total_count'] ~/ pageSize;
     }else{
       totalPage = (data['total_count'] / pageSize).floor() + 1;
     }
   });
  }
// void _search (String? query){
//     Uri url = Uri.https('api.github.com', '/search/users', {'q': query, 'per_page': '20', 'page': '0'});
//     print(url);
//     http.get(url)
//         .then((value) => data = jsonDecode(value.body))
//         .catchError((err){
//           print(err);
//   });
// }
}