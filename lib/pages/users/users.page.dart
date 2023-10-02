import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String? _query;
  bool _isvisible= false;


  TextEditingController queryTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('User $_query'),),
      body:  Center(
        child: Column(
          children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: this._isvisible,
                          onChanged: (value){
                            setState(() {
                              this._query = value;
                            });
                          },
                          controller: queryTextEditingController,
                          decoration:  InputDecoration(
                            // icon: const Icon(Icons.person),
                              suffixIcon: IconButton(onPressed: () {
                                setState(() {
                                  this._isvisible = !this._isvisible;
                                });

                              }, icon:   Icon( this._isvisible ? Icons.visibility_off : Icons.visibility ),),
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
                  IconButton(onPressed: (){
                    // this._query = queryTextEditingController.text;
                    setState(() {
                      this._query = queryTextEditingController.text;
                    });
                    _search(this._query);
                  }, icon: const Icon(Icons.search,color: Colors.indigo,))
                ],
              )
          ],
        )
      ),
    );
  }

  Future<void> _search(String? query) async {
    Uri url = Uri.https('api.github.com', '/search/users', {'q': query, 'per_page': '20', 'page': '0'});
    print(url);
   var response = await http.get(url);
   print(response.body);
  }
}