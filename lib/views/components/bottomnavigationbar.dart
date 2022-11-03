import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Wrap(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
                switch (value) {
                  case 0:
                    GoRouter.of(context).go('/homev3');
                    break;
                  case 1:
                    GoRouter.of(context).go('/homev3');
                    break;
                  case 2:
                    GoRouter.of(context).go('/homev3');
                    break;
                  case 3:
                    GoRouter.of(context).go('/homev3');
                    break;
                  default:
                    GoRouter.of(context).go('/homev3');
                    break;
                }
              });
            },
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Shopping',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Account',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
