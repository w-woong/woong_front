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

const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: '/home',
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/shopping',
    icon: Icon(Icons.shopping_cart),
    label: 'Shopping',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/login',
    icon: Icon(Icons.account_circle),
    label: 'Account',
  ),
];

class _BottomNavV2State extends State<BottomNavV2> {
  int _locationToTabIndex(String location) {
    final index = tabs
        .indexWhere((element) => location.startsWith(element.initialLocation));
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  // int _currentIndex = 0;
  void _onItemTapped(BuildContext context, int index) {
    if (index != _currentIndex) {
      context.go(tabs[index].initialLocation);
      // context.push(tabs[index].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: tabs,
      currentIndex: _currentIndex,
      // selectedItemColor: Colors.amber[800],
      onTap: (value) {
        _onItemTapped(context, value);
      },
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
