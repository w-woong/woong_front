import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/constants/routes.dart';
import 'package:woong_front/views/default/components/textview.dart';

class BottomBar extends StatefulWidget {
  final bool isSheet;
  const BottomBar({super.key, required this.isSheet});

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
                  if (widget.isSheet) {
                    Navigator.pop(context);
                    return;
                  }
                  print('a');
                  context.go(AppRouteConstant.shopping);
                  // return;
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
                  if (widget.isSheet) {
                    Navigator.pop(context);
                    return;
                  }
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
