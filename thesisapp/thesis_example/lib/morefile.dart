import 'package:flutter/material.dart';

class MODEL extends StatefulWidget {
  const MODEL({super.key});

  @override
  State<MODEL> createState() => _MODELState();
}

class _MODELState extends State<MODEL> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new project'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 5,
      ),
    );
  }
}
