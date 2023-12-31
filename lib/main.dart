import 'package:flutter/material.dart';
import 'package:flutter_shared_preference_example/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}
