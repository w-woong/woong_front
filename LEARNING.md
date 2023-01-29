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

just do
flutter run
```

## Constructors

```dart
  HomeHttp(this.baseUrl, this.bearerToken, {int? defaultTimeout}) {
    this.defaultTimeout = defaultTimeout ?? 6;
  }
  
```

## Initialize on initState
```dart
  @override
  void initState() {
    super.initState();
    context.read<CartVM>().fetch().catchError(
      (e) {
        showCupertinoModalBottomSheet(
          context: context,
          expand: false,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return LoginSheetView();
          },
        ).then((value) => context.go('/home'));
      },
      test: (e) => e is UnauthorizedException,
    ).catchError(
      (e) {
        print(e);
      },
    );
  }
```

## Close modal sheet
```dart
Navigator.pop(context);
```

## Dio error on web
```
Solution Steps:

1. Go to flutter SDK path-> flutter\bin\cache
2. Find a file by name flutter_tools.stamp, take a backup of it in some other location so that you can retain a copy then simple delete the original one.
3. Next Go to flutter\packages\flutter_tools\lib\src\web and open chrome.dart file in any editor.
4. Search for line '--disable-extension' then Comment it out.
5. and and just below it add --disable-web-security.
6. Now simple clear your IDE cache if android Studio and restart the IDE.
7. Now, Install the flutter app on you device and now you can make Internet API call.

Don’t Worry if you see this warning ‘You are using an unsupported comment-line flag: –disable-web-security. Stability and security will suffer’. This will only be soon on your local system.
```

## After upgrading flutter to 3.7.0
```
Error (Xcode): ../../../../.pub-cache/hosted/pub.dev/modal_bottom_sheet-2.1.2/lib/src/bottom_sheets/bar_bottom_sheet.dart:102:13: Error:
'ModalBottomSheetRoute' is imported from both 'package:flutter/src/material/bottom_sheet.dart' and 'package:modal_bottom_sheet/src/bottom_sheet_route.dart'.
```

```
The reason behind the error is says both material/bottom_sheet.dart and bottom_sheet_route exports the ModalBottomSheetRoute.

'ModalBottomSheetRoute' is imported from both
'package:flutter/src/material/bottom_sheet.dart' and 'package:modal_bottom_sheet/src/bottom_sheet_route.dart'.
In order to fix this issue we have to hide one of the ModalBottomSheetRoute. since we need this to be imported from bottom_sheet_route we need to hide it from material

This is the way that we can fix,

Relace

import 'package:flutter/material.dart' with

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

in the following files.

/Users/wonk/.pub-cache/hosted/pub.dev/modal_bottom_sheet-2.1.2/lib/src/material_with_modal_page_route.dart
/Users/wonk/.pub-cache/hosted/pub.dev/modal_bottom_sheet-2.1.2/lib/src/bottom_sheets/bar_bottom_sheet.dart
/Users/wonk/.pub-cache/hosted/pub.dev/modal_bottom_sheet-2.1.2/lib/src/bottom_sheets/material_bottom_sheet.dart
```