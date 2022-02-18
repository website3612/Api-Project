import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetScreen extends StatefulWidget {
  @override
  _GetScreenState createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  getUserdate() async {
    var response = await http.get(Uri.parse(
        "https://codelineinfotech.com/student_api/User/allusers.php"));
    // print("${response.body}");
    // print("${jsonDecode(response.body)}");

    var _information = jsonDecode(response.body);
    return _information;
  }

  String name = 'Deep';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("GET"),
      ),
      // ignore: missing_return
      body: FutureBuilder(
          future: getUserdate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: (snapshot.data['users'] as List).length,
                itemBuilder: (context, index) {
                  var user = snapshot.data['users'][index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user['avatar'] == ""
                          ? AssetImage('assets/images/profile.png')
                          : NetworkImage("${user['avatar']}"),
                    ),
                    subtitle:
                        Text('${user['first_name']} ${user['last_name']}'),
                    title: user['first_name'] == ""
                        ? Text("Scary Fox")
                        : Text("${user['first_name']}"),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
