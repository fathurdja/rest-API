import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApi extends StatefulWidget {
  const MyApi({super.key});

  @override
  State<MyApi> createState() => _MyApiState();
}

class _MyApiState extends State<MyApi> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "rest API",
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            var email = user['email'];
            var nameTitle = user['name']['title'];
            var nameFirst = user['name']['first'];
            var nameLast = user['name']['last'];
            var fullName = "$nameTitle $nameFirst $nameLast";
            var imageLink = user['picture']['thumbnail'];
            return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20),
                ),
                title: Text(fullName),
                subtitle: Text(email),
                trailing: CircleAvatar(
                  backgroundImage: NetworkImage(imageLink),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        child: const Icon(Icons.add),
      ),
    );
  }

  void fetchData() async {
    print("fetchData");

    const url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    users = json['results'];

    // print("user : ${users}");
    setState(() {
      users = json['results'];
    });
  }
}
