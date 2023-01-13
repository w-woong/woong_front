import 'package:flutter/material.dart';

class OrderProductView extends StatefulWidget {
  const OrderProductView({super.key});

  @override
  State<OrderProductView> createState() => _OrderProductViewState();
}

class _OrderProductViewState extends State<OrderProductView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('order products'),
    );
  }
}
