import 'package:flutter/material.dart';
import 'package:football_fraternity/screens/contacts.dart';
import 'package:football_fraternity/screens/footballers/footballers_list.dart';
import 'package:football_fraternity/screens/home.dart';
import 'package:football_fraternity/screens/messages/messages_list.dart';
import 'package:football_fraternity/screens/services.dart';
import 'package:football_fraternity/widgets/drawer.dart';
import 'package:football_fraternity/widgets/header.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ServicesScreen(),
    const ContactsScreen(),
    MessagesListScreen(),
    const FootballersListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      drawer: const AppDrawer(), 
      body: _screens[_currentIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.work),
      //       label: 'Services',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.contact_phone),
      //       label: 'Contacts',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message),
      //       label: 'Messages',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.people),
      //       label: 'Footballers',
      //     ),
      //   ],
      // ),
    );
  }
}