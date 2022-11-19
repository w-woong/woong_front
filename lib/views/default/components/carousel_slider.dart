import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselSlider extends StatefulWidget {
  final double height;
  final List<String> imgList;

  ImageCarouselSlider({super.key, required this.height, required this.imgList});

  @override
  State<ImageCarouselSlider> createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> getItems() {
    return widget.imgList.map((item) => _ImageView(src: item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    /*
    return CarouselSlider(
      items: getItems(),
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
      ),
    );
*/

    return Container(
      height: widget.height,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: getItems(),
              carouselController: _controller,
              options: CarouselOptions(
                height: widget.height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                autoPlay: false,
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
            children: widget.imgList.asMap().entries.map((entry) {
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
}

class _ImageView extends StatelessWidget {
  final String src;
  const _ImageView({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        src,
        fit: BoxFit.cover,
      ),
    );
  }
}
