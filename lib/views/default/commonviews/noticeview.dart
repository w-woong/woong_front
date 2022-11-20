import 'package:flutter/material.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/views/default/components/textview.dart';

class NoticeView extends StatelessWidget {
  final Notice notice;
  const NoticeView({super.key, required this.notice});

  List<Widget> getItems(BuildContext context, List<String> list) {
    return list.map((item) {
      return Container(
        padding: EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TitleText('\u2022'),
            Container(
              // alignment: Alignment.center,
              // padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(right: 10),
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.titleMedium?.color,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: TitleText(item)),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Text(
                notice.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getItems(context, notice.messages),
          ),
        ),
      ],
    );
  }
}
