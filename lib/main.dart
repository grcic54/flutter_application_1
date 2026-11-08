import 'package:flutter/material.dart';
import 'package:flutter_application_1/ekrani/list_ekran.dart';

void main() {
  runApp(const GamesApp());
}

class GamesApp extends StatelessWidget {
  const GamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Igre',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const ListEkran(),
    );
  }
}
