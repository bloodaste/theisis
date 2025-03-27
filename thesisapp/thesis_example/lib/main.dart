import 'package:flutter/material.dart';
import 'package:thesis_example/morefile.dart';
import 'package:thesis_example/tryinginit.dart';

void main() => runApp(MaterialApp(home: ApplicationApp()));

class ApplicationApp extends StatefulWidget {
  const ApplicationApp({super.key});

  @override
  State<ApplicationApp> createState() => _ApplicationAppState();
}

class _ApplicationAppState extends State<ApplicationApp> {
  int yearlevel = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => QWER(),
        'morefile': (context) => MODEL(),
      },
    );
  }
}
