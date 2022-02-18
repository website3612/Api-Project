import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeWork extends StatefulWidget {
  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  Future getUserData() async {
    var _answer = await http.get(Uri.parse("https://reqres.in/api/unknown"));

    print("${_answer.body}");
    print("${jsonDecode(_answer.body)}");
    var _infoAnswer = jsonDecode(_answer.body);
    return _infoAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("per_work"),
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: (snapshot.data["data"] as List).length,
              itemBuilder: (context, index) {
                // var hexColor = snapshot.data['data'][index]['Color'];
                // hexColor = hexColor.replaceAll("#", "");
                // if (hexColor.length == 6) {
                //   hexColor = "0x" + "FF" + hexColor;
                // }
                // if (hexColor.length == 8) {
                //   hexColor = Color(int.parse("$hexColor"));
                // }
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                  title: Text(snapshot.data['data'][index]["name"]),
                  subtitle: Text('${snapshot.data['data'][index]['year']}'),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
