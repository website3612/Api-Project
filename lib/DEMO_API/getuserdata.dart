import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetUserDataScreen extends StatelessWidget {
  Future getUserData() async {
    http.Response response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    print('userData response ====${response.body}');
    print('userData response ====${jsonDecode(response.body)}');
    var result = jsonDecode(response.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Method'),
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: (snapshot.data['data'] as List).length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('${snapshot.data['data'][index]['avatar']}'),
                ),
                subtitle: Text('${snapshot.data['data'][index]['email']}'),
                title: Text(
                    '${snapshot.data['data'][index]['first_name']} ${snapshot.data['data'][index]['last_name']}'),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
