import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User"),),
      body:  Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.indigo
                      ),
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ))
          ],
        )
      ),
    );
  }
}