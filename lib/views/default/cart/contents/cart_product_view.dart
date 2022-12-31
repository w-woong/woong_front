import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';
import 'package:woong_front/views/default/components/imageview.dart';
import 'package:woong_front/views/default/components/textview.dart';

class CartProductView extends StatefulWidget {
  final double width;
  final CartProduct cartProduct;
  const CartProductView(
      {super.key, required this.width, required this.cartProduct});

  @override
  State<CartProductView> createState() => _CartProductViewState();
}

class _CartProductViewState extends State<CartProductView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SquareImageView(
                url:
                    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                size: 200,
              ),
              Container(
                // margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(5),
                // height: 100,
                width: widget.width - 200,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.cartProduct.productID,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.cartProduct.cost.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
