import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'full_data.dart';

class NewsApiData extends StatefulWidget {
  @override
  _NewsApiDataState createState() => _NewsApiDataState();
}

class _NewsApiDataState extends State<NewsApiData> {
  List<Map<String, dynamic>> News = [
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
  ];

  Future getinformation() async {
    http.Response _information = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=4f154e23b08a4bd1a24a0c3af5cb527b"));
    print('userData response ====${_information.body}');
    print('userData response ====${jsonDecode(_information.body)}');
    var result = jsonDecode(_information.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Text(
              "Apka Bharosa",
            ),
            Text(
              "24/7",
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getinformation(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      color: Colors.amber,
                      width: screenSize.width,
                      height: screenSize.height / 5,
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (snapshot.data['articles'] as List).length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullData(
                                    images: snapshot.data['articles'][index]
                                        ["urlToImage"],
                                    author: snapshot.data["articles"][index]
                                        ["author"],
                                    description: snapshot.data["articles"]
                                        [index]["description"],
                                    url: snapshot.data["articles"][index]
                                        ["url"],
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 60, bottom: 20),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                  height: screenSize.height / 7,
                                  width: screenSize.width,
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data["articles"][index]
                                            ["title"],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50, left: 210),
                                        child: Text(
                                          snapshot.data["articles"][index]
                                              ['publishedAt'],
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: -10,
                                    left: -20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data['articles']
                                                      [index]["urlToImage"]),
                                              fit: BoxFit.cover),
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: screenSize.width / 3.5,
                                      height: screenSize.height / 7,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    width: screenSize.width,
                    height: screenSize.height * 2,
                    color: Colors.white,
                  ),
                ],
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
