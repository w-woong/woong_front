import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/views/default/components/textview.dart';

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
      // color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: ElevatedButton(
                child: Text('Cart'),
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
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: OutlinedButton(
                child: Text('Purchase'),
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
