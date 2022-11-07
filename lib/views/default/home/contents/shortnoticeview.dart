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
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    print('_ShortNoticeSliderViewState build');

    List<ShortNotice> noticeList =
        context.select((ShortNoticeVM value) => value.noticeList);

    return Container(
      height: 120,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: getItems(noticeList),
              carouselController: _controller,
              options: CarouselOptions(
                height: 120,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                autoPlay: true,
                onPageChanged: ((index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: noticeList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> getItems(List<ShortNotice> list) {
    return list.map((item) => ShortNoticeView(item: item)).toList();
  }
}

class ShortNoticeView extends StatefulWidget {
  final ShortNotice item;
  const ShortNoticeView({super.key, required this.item});

  @override
  State<ShortNoticeView> createState() => _ShortNoticeViewState();
}

class _ShortNoticeViewState extends State<ShortNoticeView> {
  @override
  Widget build(BuildContext context) {
    print('_ShortNoticeViewState build');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40.0),
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
            size: 50,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Expanded(
            // width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.item.description,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
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

    // return Container(
    //   child: Container(
    //     margin: EdgeInsets.all(5.0),
    //     child: ClipRRect(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //         child: Stack(
    //           children: <Widget>[
    //             Image.network(widget.item.imgUrl,
    //                 fit: BoxFit.cover, width: 1000.0),
    //             Positioned(
    //               bottom: 0.0,
    //               left: 0.0,
    //               right: 0.0,
    //               child: Container(
    //                 decoration: const BoxDecoration(
    //                   gradient: LinearGradient(
    //                     colors: [
    //                       Color.fromARGB(200, 0, 0, 0),
    //                       Color.fromARGB(0, 0, 0, 0)
    //                     ],
    //                     begin: Alignment.bottomCenter,
    //                     end: Alignment.topCenter,
    //                   ),
    //                 ),
    //                 padding: const EdgeInsets.symmetric(
    //                     vertical: 10.0, horizontal: 20.0),
    //                 child: const Text(
    //                   'No. image',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 20.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )),
    //   ),
    // );
  }
}
