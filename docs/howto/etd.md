
- CupertinoPageScaffold
```dart
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Container(),
        middle: TitleText(
          'Product',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),

      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _ProductBody(),
                ),
                BottomBar(),
              ],
            ),
          ],
        ),
      ),
    );
```