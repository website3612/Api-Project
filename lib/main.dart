import 'package:flutter/material.dart';
import 'package:under_ground/Modal_data/modal/modal1/main_screen.dart';
import 'package:under_ground/pra_work.dart';
import 'package:under_ground/practice_page/get_practice/get_data.dart';
import 'package:under_ground/practice_page/get_practice/get_unknown.dart';

import 'DEMO_API/getuserdata.dart';
import 'practice_page/news/news_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsApiData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
