import 'package:flutter/material.dart';

class TitleLargeText extends StatelessWidget {
  final String text;
  late TextAlign align;
  TitleLargeText({super.key, required this.text, TextAlign? align}) {
    this.align = align ?? TextAlign.start;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  late TextAlign align;

  BodyText({super.key, required this.text, TextAlign? align}) {
    this.align = align ?? TextAlign.start;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
