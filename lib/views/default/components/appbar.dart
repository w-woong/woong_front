import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/home/home.dart';

class DefaultAppBar extends StatefulWidget {
  const DefaultAppBar({super.key});

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      // expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '${context.select((AppConfig config) => config.title)} / ${context.select((HomeVM value) => value.home.title)}',
        ),
        background: const FlutterLogo(),
      ),
    );
  }
}
