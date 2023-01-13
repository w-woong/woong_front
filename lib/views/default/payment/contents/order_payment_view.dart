import 'package:flutter/material.dart';

class OrderPaymentView extends StatefulWidget {
  const OrderPaymentView({super.key});

  @override
  State<OrderPaymentView> createState() => _OrderPaymentViewState();
}

class _OrderPaymentViewState extends State<OrderPaymentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('order payment'),
    );
  }
}
