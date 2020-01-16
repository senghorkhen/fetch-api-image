import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List users;
  Map userData;
  // teanh data
  Future setUser() async { // Future jea keyword ter vea ng mean ey tt nv pel future
    String url = "https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=beautiful&image_type=photo&pretty=true";
    http.Response response = await http.get(url);
    userData = json.decode(response.body); // yg yk data ng tv use under
    setState(() { // vea ng update
      users = userData['hits']; 
    });
  }
  @override
  void initState() {
    super.initState();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        title: Text("User information!!!"),
      ),
      // yg yk data mk use
      body: ListView.builder(
        // itemCount: 10, // ber yg jg oy vea mean data man dong asray ler yg jea nak define
        itemCount: users == null ? 0 : users.length, // vea chenh data all
        itemBuilder: (BuildContext context, int i){
          final user = users[i];
          return Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(user["previewURL"]),
                      ),
                      SizedBox(width: 10),
                      Text(user["user"]),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Image.network(user["largeImageURL"]),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}