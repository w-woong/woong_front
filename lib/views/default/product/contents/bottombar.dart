import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              child: Text('Cart'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: TextButton(
              child: Text('Buy'),
              onPressed: () {
                //
              },
            ),
          ),
        ],
      ),
    );
  }
}
