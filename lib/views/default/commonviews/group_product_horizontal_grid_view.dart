import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/model/group.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/views/default/commonviews/product_thumb_view.dart';

class GroupProductHorizontalGridView extends StatefulWidget {
  final Group group;
  final String path;
  const GroupProductHorizontalGridView(
      {super.key, required this.group, required this.path});

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
              children: getItems(widget.group.products ?? []),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getItems(List<Product> list) {
    return list
        .map((product) =>
            ProductThumbWithBottom(path: widget.path, product: product))
        .toList();
  }
}
