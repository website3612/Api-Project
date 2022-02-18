import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:under_ground/practice_page/news/full_data.dart';

import 'modal_screen.dart';

class ModalData extends StatefulWidget {
  @override
  _ModalDataState createState() => _ModalDataState();
}

class _ModalDataState extends State<ModalData> {
  List<Map<String, dynamic>> news = [
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
    {"Information": "1"},
  ];

  Future<Welcome> getInformation() async {
    http.Response _information = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c9412ce43a7a4a0081ebf78215aea115"),
    );
    return welcomeFromJson(_information.body);
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
      body: FutureBuilder<Welcome>(
        future: getInformation(),
        builder: (context, AsyncSnapshot<Welcome> snapshot) {
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
                      itemCount: snapshot.data.articles.length,
                      itemBuilder: (context, index) {
                        final _user = snapshot.data.articles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullData(
                                    images: _user.urlToImage,
                                    author: _user.author,
                                    description: _user.description,
                                    url: _user.url,
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            offset: Offset(0, 2))
                                      ]),
                                  height: screenSize.height / 7,
                                  width: screenSize.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 110),
                                        child: Text(
                                          _user.title,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 35, left: 250),
                                        child: Text(
                                          "${_user.publishedAt}",
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
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2,
                                                offset: Offset(0, 2))
                                          ],
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${_user.urlToImage}"),
                                              fit: BoxFit.cover),
                                          // color: Colors.black,
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
