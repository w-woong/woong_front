import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/components/imageview.dart';
import 'package:woong_front/views/default/product/product_sheet.dart';

class ShoppingView extends StatefulWidget {
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const ShoppingView({super.key, required this.bottomTabs});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ShoppingBody(),
      bottomNavigationBar: BottomNavV2(
        tabs: widget.bottomTabs,
      ),
    );
  }
}

class _ShoppingBody extends StatefulWidget {
  const _ShoppingBody({super.key});

  @override
  State<_ShoppingBody> createState() => _ShoppingBodyState();
}

class _ShoppingBodyState extends State<_ShoppingBody> {
  double indicatorHeight = 0.0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _onRefresh() async {
    setState(() {
      indicatorHeight = 120.0;
    });
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      indicatorHeight = 0.0;
    });
    return Future<void>.value();
  }

  @override
  Widget build(BuildContext context) {
    int numCols = 2;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return RefreshIndicator(
          key: refreshKey,
          edgeOffset: 120,
          displacement: 20,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              DefaultAppBar(
                  title: 'Shopping', showCart: true, showAccount: true),
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  // color: Colors.amber,
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 300),
                  height: indicatorHeight,
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: constraints.maxWidth / numCols,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  // childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // return Container(
                    //   alignment: Alignment.center,
                    //   color: Colors.red[100 * (index % 9)],
                    //   child: Text('grid item'),
                    // );
                    return Container(
                      // margin: const EdgeInsets.all(5.0),
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // context.go('/shopping/product');

                              showCupertinoModalBottomSheet(
                                context: context,
                                expand: false,
                                useRootNavigator: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return ProductSheetView();
                                },
                              );
                            },
                            child: ImageView.vertical(),
                          ),
                          Container(
                            margin: EdgeInsets.all(2),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'name of the image asdf',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                        maxLines: 2,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$ 2,000',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
