import 'package:flutter/material.dart';

class MySliverAppBar extends StatefulWidget {
  final String title;
  const MySliverAppBar({super.key, required this.title});

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
        ),
      ],
    );
  }
}
