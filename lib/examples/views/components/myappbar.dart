import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;
  const MyAppBar({super.key, required this.appBar});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text(
        'Home',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/profile');
          },
          icon: const Icon(
            color: Colors.black,
            Icons.account_circle_outlined,
          ),
        )
      ],
    );
  }
}
