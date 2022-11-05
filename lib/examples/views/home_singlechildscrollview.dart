import 'package:flutter/material.dart';
import 'package:woong_front/examples/views/components/myappbar.dart';
import 'package:woong_front/examples/views/components/mysliverappbar.dart';
import 'package:woong_front/examples/views/components/bottomnavigationbar.dart';
import 'package:woong_front/examples/views/home_body_singlechildscrollview.dart';

class HomeSingleChildScrollView extends StatefulWidget {
  const HomeSingleChildScrollView({super.key});

  @override
  State<HomeSingleChildScrollView> createState() =>
      _HomeSingleChildScrollViewState();
}

class _HomeSingleChildScrollViewState extends State<HomeSingleChildScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: MyAppBar(appBar: AppBar()),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: MyHomeBodySingleChildScrollView(),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
