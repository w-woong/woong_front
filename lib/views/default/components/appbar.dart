import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/home/homevm.dart';

class DefaultAppBar extends StatefulWidget {
  final String title;
  const DefaultAppBar({super.key, required this.title});

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      // expandedHeight: 150,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '${context.select((AppConfig config) => config.title)} / ${widget.title}',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        // background: Image.network(
        //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=79',
        //   fit: BoxFit.cover,
        // ),
      ),
      // automaticallyImplyLeading: false,
      // leadingWidth: 0,
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back),
      //   onPressed: () {},
      // ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}
