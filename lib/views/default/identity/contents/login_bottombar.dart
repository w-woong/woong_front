import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginBottomBar extends StatefulWidget {
  const LoginBottomBar({super.key});

  @override
  State<LoginBottomBar> createState() => _LoginBottomBarState();
}

class _LoginBottomBarState extends State<LoginBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      // color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                child: Text('Cart'),
                onPressed: () async {
                  Navigator.pop(context);
                },
                // style: TextButton.styleFrom(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   foregroundColor: Theme.of(context).primaryColorLight,
                // ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: OutlinedButton(
                child: const Text('Purchase'),
                onPressed: () {
                  Navigator.pop(context);
                },
                // style: TextButton.styleFrom(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   foregroundColor: Theme.of(context).primaryColorLight,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
