import 'package:citifix/feature/workerFeature/home/Home.dart';
import 'package:citifix/feature/workerFeature/profile/profle.dart';
import 'package:citifix/feature/workerFeature/tasks/tasks.dart';
import 'package:flutter/material.dart';

class Mainscreenwroker extends StatefulWidget {
  const Mainscreenwroker({super.key});

  @override
  State<Mainscreenwroker> createState() => _MainscreenwrokerState();
}

class _MainscreenwrokerState extends State<Mainscreenwroker> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    TaskDetailsPage(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFF97316),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'DASHBOARD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'TASKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}
