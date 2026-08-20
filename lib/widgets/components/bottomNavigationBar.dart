import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  // final ValueChanged<int> onDestinationSelected;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    //  required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFBF8F1),
      selectedItemColor: Color(0xFF71804A),
      unselectedItemColor: Color(0xFF262D26),
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Browse'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
