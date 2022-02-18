import 'package:flutter/material.dart';

class FullData extends StatefulWidget {
  final String author;
  final String images;
  final String description;
  final String url;

  const FullData(
      {Key key, this.author, this.images, this.description, this.url})
      : super(key: key);

  @override
  _FullDataState createState() => _FullDataState();
}

class _FullDataState extends State<FullData> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenSize.height / 2.5,
            width: screenSize.width,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.images))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 20),
            child: Text(
              widget.author,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: screenSize.height / 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Link",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.url,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
