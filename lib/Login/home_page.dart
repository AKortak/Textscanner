import 'package:flutter/material.dart';
import 'package:hrw_textscanner/Login/SettingsScreen.dart';
import 'package:hrw_textscanner/optical_character_recognition/optical_character_recognition.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  switchScreen() {
    switch (_selectedIndex) {
      case 0:
        return PictureScanner();
      case 1:
        return SizedBox();
      case 2:
        return SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lightBlueAccent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Option 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Option 2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Einstellungen',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
        body: switchScreen(),
      ),
    );
  }
}
