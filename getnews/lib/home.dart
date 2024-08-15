import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getnews/detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _posts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState(); //1
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(  //2
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.blue, // Warna latar belakang yang sesuai
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppBar(
            backgroundColor: Colors.transparent, // Membuat AppBar transparan
            elevation: 0, // Menghilangkan bayangan
            title: const Text(
              'StarNews',
              style: TextStyle(
                color: Colors.white, // Warna teks judul
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 150, // Lebar yang lebih kecil
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 14), // Ukuran font lebih kecil
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(fontSize: 14), // Ukuran font hint yang lebih kecil
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8), // Padding yang lebih kecil
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _getData(query: _searchController.text);
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder( //3
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: _posts[index]['urlToImage'] != null
                  ? Image.network(_posts[index]['urlToImage'])
                  : const Center(),
            ),
            title: Text('${_posts[index]['title']}'),
            subtitle: Text('${_posts[index]['description']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(//4
                    url: _posts[index]['url'],
                    title: _posts[index]['title'],
                    content: _posts[index]['content'],
                    publishedAt: _posts[index]['publishedAt'],
                    author: _posts[index]['author'],
                    urlToImage: _posts[index]['urlToImage'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future _getData({String query = ''}) async { //1
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=68bb03a5f5474bcea81d767fb5283ca2&q=$query')); //2

      if (response.statusCode == 200) { //3
        final data = json.decode(response.body);
        setState(() {
          _posts = data['articles'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}