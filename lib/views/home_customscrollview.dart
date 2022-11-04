import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/mocks/database.dart';
import 'package:woong_front/views/components/bottomnavigationbar.dart';

class HomeCustomScrollView extends StatefulWidget {
  const HomeCustomScrollView({super.key});

  @override
  State<HomeCustomScrollView> createState() => _HomeCustomScrollViewState();
}

class _HomeCustomScrollViewState extends State<HomeCustomScrollView> {
  @override
  Widget build(BuildContext context) {
    int a = Provider.of<int>(context);
    List<Product> products = Provider.of<List<Product>>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Home'),
              background: FlutterLogo(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text(a.toString()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.amber,
              height: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.orange,
              height: 400,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.amber,
              height: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.orange,
              height: 400,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.amber,
              height: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.orange,
              height: 400,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: index.isOdd ? Colors.blue : Colors.red[200],
                  height: 80,
                );
              },
              childCount: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('scroll'),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var name = products[index].name;
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $name'),
                );
              },
              childCount: products.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBarV2(),
    );
  }
}
