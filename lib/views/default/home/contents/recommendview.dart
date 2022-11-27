import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:woong_front/domains/home/home_vm.dart';
import 'package:woong_front/domains/product/group.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/recommend/recommend.dart';

class RecommendSliderView extends StatefulWidget {
  const RecommendSliderView({super.key});

  @override
  State<RecommendSliderView> createState() => _RecommendSliderViewState();
}

class _RecommendSliderViewState extends State<RecommendSliderView> {
  @override
  Widget build(BuildContext context) {
    print('_RecommendSliderViewState build');
    List<Group> mainProducts =
        context.select((HomeVM vm) => vm.home.mainProducts);
    print(mainProducts);
    List<Product> recommendedProducts = context.select((HomeVM vm) {
      var mainProducts = vm.home.mainProducts;
      if (mainProducts.isEmpty) {
        return [];
      }
      return mainProducts[0].products;
    });
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Recommend',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: getProducts(recommendedProducts),
            options: CarouselOptions(
              height: 300,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
            ),
          )
        ],
      ),
    );
    // return CarouselSlider(
    //   items:
    //       getItems(context.select((RecommendVM value) => value.recommendList)),
    //   options: CarouselOptions(
    //     height: 300,
    //     enlargeCenterPage: false,
    //     enableInfiniteScroll: false,
    //   ),
    // );
  }

  // List<Widget> getItems(List<Recommend> list) {
  //   return list.map((item) => RecommendView(item: item)).toList();
  // }
  List<Widget> getProducts(List<Product> list) {
    return list.map((item) => RecommendView(item: item)).toList();
  }
}

class RecommendView extends StatefulWidget {
  Product item;
  RecommendView({super.key, required this.item});

  @override
  State<RecommendView> createState() => _RecommendViewState();
}

class _RecommendViewState extends State<RecommendView> {
  @override
  Widget build(BuildContext context) {
    print('_ShortNoticeViewState build');
    return Container(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    widget.item.imgUrl,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
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
