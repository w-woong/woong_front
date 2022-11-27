import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/group.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/views/default/commonviews/product_thumb_view.dart';

class GroupProductHorizontalGridView extends StatefulWidget {
  Group group;
  GroupProductHorizontalGridView({super.key, required this.group});

  @override
  State<GroupProductHorizontalGridView> createState() =>
      _GroupProductHorizontalGridViewState();
}

class _GroupProductHorizontalGridViewState
    extends State<GroupProductHorizontalGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  widget.group.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Container(
            height: 450,
            child: GridView(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450 / 2,
                mainAxisExtent: 150,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              children: getItems(widget.group.products),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getItems(List<Product> list) {
    return list
        .map((product) => ProductThumbWithBottom(product: product))
        .toList();
  }
}
