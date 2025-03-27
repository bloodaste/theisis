import 'package:flutter/material.dart';

class Newrfid extends StatefulWidget {
  const Newrfid({super.key});

  @override
  State<Newrfid> createState() => _NewrfidState();
}

class _NewrfidState extends State<Newrfid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('newrfid'),
      ),
    );
  }
}
