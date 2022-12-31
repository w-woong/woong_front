import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavV2 extends StatefulWidget {
  final List<ScaffoldWithNavBarTabItem> tabs;
  const BottomNavV2({super.key, required this.tabs});

  @override
  State<BottomNavV2> createState() => _BottomNavV2State();
}

class _BottomNavV2State extends State<BottomNavV2> {
  int _locationToTabIndex(String location) {
    final index = widget.tabs
        .indexWhere((element) => location.startsWith(element.initialLocation));
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  // int _currentIndex = 0;
  void _onItemTapped(BuildContext context, int index) {
    if (index != _currentIndex) {
      context.go(widget.tabs[index].initialLocation);
      // context.push(tabs[index].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.tabs,
      currentIndex: _currentIndex,
      onTap: (value) {
        _onItemTapped(context, value);
      },
      // selectedItemColor: Colors.amber[800],
      // unselectedItemColor: Colors.grey,
      // showUnselectedLabels: true,
      // showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      // selectedIconTheme: Theme.of(context).bottomAppBarTheme.,
    );
  }
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key, required this.child});
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );

    // return Scaffold(
    //   body: widget.child,
    //   bottomNavigationBar: const BottomNavV2(
    //     tabs: tabs,
    //   ),
    // );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
