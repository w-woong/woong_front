import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/domains/notice/noticevm.dart';

class ShortNoticeSliderView extends StatefulWidget {
  const ShortNoticeSliderView({super.key});

  @override
  State<ShortNoticeSliderView> createState() => _ShortNoticeSliderViewState();
}

class _ShortNoticeSliderViewState extends State<ShortNoticeSliderView> {
  @override
  Widget build(BuildContext context) {
    print('_ShortNoticeSliderViewState build');
    return CarouselSlider(
      items:
          getItems(context.select((ShortNoticeVM value) => value.noticeList)),
      options: CarouselOptions(height: 150, enlargeCenterPage: true),
    );
  }

  List<Widget> getItems(List<ShortNotice> list) {
    return list.map((item) => ShortNoticeView(item: item)).toList();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       // mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Image.network(
  //           'https://picsum.photos/250?image=9',
  //           // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
  //           fit: BoxFit.contain,
  //         ),
  //         Image.network(
  //           'https://picsum.photos/250?image=9',
  //           // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
  //           fit: BoxFit.contain,
  //         ),
  //       ],
  //     ),
  //   );
  // }

}

class ShortNoticeView extends StatefulWidget {
  ShortNotice item;
  ShortNoticeView({super.key, required this.item});

  @override
  State<ShortNoticeView> createState() => _ShortNoticeViewState();
}

class _ShortNoticeViewState extends State<ShortNoticeView> {
  @override
  Widget build(BuildContext context) {
    print('_ShortNoticeViewState build');
    return Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(widget.item.imgUrl,
                    fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: const Text(
                      'No. image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
