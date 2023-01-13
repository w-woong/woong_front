# Learning

##
```
flutter pub add http

flutter pub add url_launcher
```

## stick a widget on top of keyboard
```dart
Widget _buildContent(BuildContext context) {
  return Stack(
    children: [
      Column(
        children: [
          Expanded(
            child: YOUR_SCROLLING_AREA_HERE,
          ),
          YOUR_PINNED_WIDGET_HERE,
        ],
      ),
    ],
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Title'),
    ),
    body: _buildContent(context),
  );
}
```

## int to double?
```
flutter: type 'int' is not a subtype of type 'double?' in type cast
[VERBOSE-2:dart_vm_initializer.cc(41)] Unhandled Exception: type 'int' is not a subtype of type 'double?' in type cast
#0      CartProduct._readDouble
package:woong_front/…/model/cart_product.dart:41
#1      _$CartProductFromJson
package:woong_front/…/model/cart_product.g.dart:18
#2      new CartProduct.fromJson
package:woong_front/…/model/cart_product.dart:77
#3      _$CartFromJson.<anonymous closure>
package:woong_front/…/model/cart.g.dart:15
#4      MappedListIterable.elementAt (dart:_internal/iterable.dart:413:31)
#5      ListIterator.moveNext (dart:_internal/iterable.dart:342:26)
#6      new _GrowableList._ofEfficientLengthIterable (dart:core-patch/growable_array.dart:189:27)
#7      new _GrowableList.of (dart:core-patch/growable_array.dart:150:28)
#8      new List.of (dart:core-patch/array_patch.dart:51:28)
#9      ListIterable.toList (dart:_internal/iterable.dart:213:44)
#10     _$CartFromJson (package:woong_front/domains/order<…>
```

## CocoaPods not installed or not in valid state.
```
brew install cocoapods

Android studio 
File > Invalidate Caches / Restart
```