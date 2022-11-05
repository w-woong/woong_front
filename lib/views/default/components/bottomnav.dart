import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultBottomNav extends StatefulWidget {
  const DefaultBottomNav({super.key});

  @override
  State<DefaultBottomNav> createState() => _DefaultBottomNavState();
}

class _DefaultBottomNavState extends State<DefaultBottomNav> {
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
                    GoRouter.of(context).go('/');
                    break;
                  // case 1:
                  //   GoRouter.of(context).go('/homev3');
                  //   break;
                  // case 2:
                  //   GoRouter.of(context).go('/homev3');
                  //   break;
                  // case 3:
                  //   GoRouter.of(context).go('/homev3');
                  //   break;
                  default:
                    GoRouter.of(context).go('/');
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

class BottomNavV2 extends StatefulWidget {
  const BottomNavV2({super.key});

  @override
  State<BottomNavV2> createState() => _BottomNavV2State();
}

class _BottomNavV2State extends State<BottomNavV2> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.pink,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
