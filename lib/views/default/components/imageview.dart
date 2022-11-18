import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageView extends StatelessWidget {
  late bool isVertical;

  ImageView({super.key}) : isVertical = false;

  ImageView.vertical() {
    isVertical = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // double width = constraints.maxWidth > constraints.maxHeight
        //     ? constraints.maxHeight
        //     : constraints.maxWidth;
        // double height = constraints.maxHeight > constraints.maxWidth
        //     ? constraints.maxWidth
        //     : constraints.maxHeight;
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Image.network(
            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            fit: BoxFit.fill,
            width: isVertical ? constraints.maxWidth : constraints.maxWidth / 2,
            height:
                isVertical ? constraints.maxWidth : constraints.maxWidth / 2,
          ),
        );
      },
    );
  }
}
