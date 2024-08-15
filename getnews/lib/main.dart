import 'package:flutter/material.dart';
import 'package:getnews/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {  // 1
  const MyApp({super.key});

  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //2
      debugShowCheckedModeBanner: false,
      title: 'StarNews',
      theme: ThemeData(scaffoldBackgroundColor: Colors.lightBlue[50]),
      home: const Home(), //3
    );
  }
}