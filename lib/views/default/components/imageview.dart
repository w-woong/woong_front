import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageView extends StatelessWidget {
  final String url;
  const ImageView({super.key, required this.url});

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
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Image.network(
            url,
            fit: BoxFit.fill,
            // width: constraints.maxWidth,
            height: constraints.maxWidth,
          ),
        );
      },
    );
  }
}
