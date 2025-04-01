import 'package:flutter/material.dart';

class Registerfid extends StatefulWidget {
  const Registerfid({super.key});

  @override
  State<Registerfid> createState() => _RegisterfidState();
}

class _RegisterfidState extends State<Registerfid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register RFID'),
      ),
    );
  }
}
