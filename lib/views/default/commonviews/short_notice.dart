import 'package:flutter/material.dart';
import 'package:woong_front/domains/notice/model/notice.dart';
import 'package:woong_front/views/default/components/textview.dart';

class ShortNoticeView extends StatefulWidget {
  final ShortNotice shortNotice;
  ShortNoticeView({super.key, required this.shortNotice});

  @override
  State<ShortNoticeView> createState() => _ShortNoticeViewState();
}

class _ShortNoticeViewState extends State<ShortNoticeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Icon(
          //   Icons.delivery_dining_outlined,
          //   size: 50,
          //   color: Colors.black54,
          // ),
          const ImageIcon(
            // NetworkImage(widget.item.imgUrl),
            AssetImage(
                'assets/images/icons/2x/outline_notification_important_black_24dp.png'),
            size: 40,
            // color: Colors.black,
          ),
          const SizedBox(width: 10),
          Expanded(
            // width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: TitleText(widget.shortNotice.name)),
                    TextButton(
                      onPressed: () {
                        //
                      },
                      child: Text('more'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                BodyText(widget.shortNotice.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
