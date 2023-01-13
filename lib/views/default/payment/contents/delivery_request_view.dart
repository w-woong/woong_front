import 'package:flutter/material.dart';

class DeliveryRequestView extends StatefulWidget {
  const DeliveryRequestView({super.key});

  @override
  State<DeliveryRequestView> createState() => _DeliveryRequestViewState();
}

class _DeliveryRequestViewState extends State<DeliveryRequestView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('delivery request'),
    );
  }
}
