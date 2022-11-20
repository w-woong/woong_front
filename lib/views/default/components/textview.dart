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

class TitleText extends StatelessWidget {
  final String text;
  late TextAlign align;
  TextStyle? style;
  TitleText(this.text, {super.key, TextAlign? align, TextStyle? style}) {
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
      style: style ?? Theme.of(context).textTheme.titleMedium,
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  late TextAlign align;
  TextStyle? style;

  BodyText(this.text, {super.key, TextAlign? align, TextStyle? style}) {
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
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
