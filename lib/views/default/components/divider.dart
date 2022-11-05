import 'package:flutter/material.dart';

class DividerView extends StatelessWidget {
  const DividerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
      color: Colors.black12,
    );
  }
}
