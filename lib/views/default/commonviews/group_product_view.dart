import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/group.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/views/default/commonviews/product_thumb_view.dart';

class GroupProductView extends StatefulWidget {
  Group group;
  GroupProductView({super.key, required this.group});

  @override
  State<GroupProductView> createState() => _GroupProductViewState();
}

class _GroupProductViewState extends State<GroupProductView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  widget.group.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: getProducts(widget.group.products),
            options: CarouselOptions(
              height: 300,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getProducts(List<Product> list) {
    return list.map((product) => ProductThumbView(product: product)).toList();
  }
}
