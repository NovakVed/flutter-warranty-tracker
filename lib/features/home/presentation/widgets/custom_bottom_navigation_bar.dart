import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.timeline_outlined),
          selectedIcon: Icon(Icons.timeline),
          label: 'Timeline',
        ),
        NavigationDestination(
          icon: Icon(Icons.category_outlined),
          selectedIcon: Icon(Icons.category),
          label: 'Categories',
        ),
      ],
    );
  }
}
