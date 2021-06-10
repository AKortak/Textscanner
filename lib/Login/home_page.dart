import 'package:flutter/material.dart';
import 'package:hrw_textscanner/Login/SettingsScreen.dart';
import 'package:hrw_textscanner/firebase/CloudDbScreen.dart';
import 'package:hrw_textscanner/optical_character_recognition/optical_character_recognition.dart';
import 'package:hrw_textscanner/sqflite/LocalDbScreen.dart';
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
        return CloudDbScreen();
      case 2:
        return LocalDbScreen();
      case 3:
        return SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          key: ValueKey("BottomNavigationBar"),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 26,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lightBlueAccent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, key: ValueKey("Scanner")),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined, key: ValueKey("CloudButton")),
              label: 'Cloud',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.save_outlined, key: ValueKey("LocalButton")),
              label: 'Local',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, key: ValueKey("SettingsButton")),
              label: 'Settings',
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
