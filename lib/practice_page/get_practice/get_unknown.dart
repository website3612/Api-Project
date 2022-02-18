import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetUnknown extends StatefulWidget {
  @override
  _GetUnknownState createState() => _GetUnknownState();
}

class _GetUnknownState extends State<GetUnknown> {
  getUserdate() async {
    var response = await http.get(Uri.parse("https://reqres.in/api/unknown"));
    // print("${response.body}");
    // print("${jsonDecode(response.body)}");

    var _information = jsonDecode(response.body);
    return _information;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("GetUnknown"),
      ),
      // ignore: missing_return
      body: FutureBuilder(
          future: getUserdate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: (snapshot.data['data'] as List).length,
                itemBuilder: (context, index) {
                  var user = snapshot.data['data'][index];
                  // var hexColor = user['Color'];
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
                    subtitle: Text('${user['name']} ${user['year']}'),
                    title: user['id'] == "5"
                        ? Text("Scary Fox")
                        : Text("${user['id']}"),
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
