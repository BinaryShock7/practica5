import 'package:flutter/material.dart';
import 'package:practica5/screens/detail_character_screen.dart';
import 'package:practica5/screens/list_character_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: "title");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 18, 175, 201)
      ),
      home: const ListCharacterScreen(),
      routes: {
        '/detail' : (BuildContext context) => DetailCharacterScreen(),
      },
    );
  }
}
