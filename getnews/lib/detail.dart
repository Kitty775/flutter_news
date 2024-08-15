import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String url;
  final String title;
  final String content;
  final String publishedAt;
  final String author;
  final String urlToImage;

  const Detail(
      {super.key,
      required this.url,
      required this.title,
      required this.content,
      required this.publishedAt,
      required this.author,
      required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // ignore: unnecessary_null_comparison
          urlToImage != null
              ? Image.network(urlToImage)
              : Container(
                  height: 250,
                  color: Color.fromARGB(255, 133, 11, 62),
                ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  publishedAt,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 5),
                Text(content),
                const Divider(),
                Text('Author: $author'),
                Text(url),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}