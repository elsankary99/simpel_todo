import 'package:flutter/material.dart';
import 'package:sqflite_app/pages/person_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PersonList());
  }
}
