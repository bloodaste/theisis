import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/pages/inventorystatus.dart';
import 'package:theisi_app/front%20_end_app/pages/inventory.dart';
import 'package:theisi_app/front%20_end_app/pages/newrfidpage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [
      Frontpage(),
      Analyticspage(),
      Newrfid(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits_rounded),
            label: 'Product Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scanner),
            label: 'New RFID',
          ),
        ],
      ),
    );
  }
}
