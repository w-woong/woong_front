
- Refresh indicator
```dart
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return RefreshIndicator(
          key: refreshKey,
          edgeOffset: 120,
          displacement: 20,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              const DefaultAppBar(
                title: 'Shopping',
              ),
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
                  maxCrossAxisExtent: constraints.maxWidth / 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.red[100 * (index % 9)],
                      child: Text('grid item'),
                    );
                  },
                  childCount: 100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

```