import 'package:flutter/material.dart';
import 'package:woong_front/domains/notice/notice.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                TitleLargeText(text: widget.shortNotice.name),
                const SizedBox(height: 5),
                BodyText(text: widget.shortNotice.description),
                // const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    print('object');
                  },
                  child: Text('more'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(5.0),
                    minimumSize: Size.zero,
                    // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
