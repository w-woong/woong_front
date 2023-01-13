import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/payment/contents/delivery_request_view.dart';
import 'package:woong_front/views/default/payment/contents/delivery_view.dart';
import 'package:woong_front/views/default/payment/contents/order_payment_view.dart';
import 'package:woong_front/views/default/payment/contents/order_product_view.dart';
import 'package:woong_front/views/default/payment/contents/payment_method_view.dart';

class PaymentView extends StatefulWidget {
  final String title;
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const PaymentView({super.key, required this.title, required this.bottomTabs});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PaymentBody(title: widget.title),
      bottomNavigationBar: BottomNavV2(tabs: widget.bottomTabs),
    );
  }
}

class _PaymentBody extends StatefulWidget {
  final String title;
  const _PaymentBody({super.key, required this.title});

  @override
  State<_PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<_PaymentBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        DefaultAppBar(
          title: widget.title,
          showAccount: true,
          showCart: true,
        ),
        SliverToBoxAdapter(
          child: DeliveryView(),
        ),
        SliverToBoxAdapter(
          child: DeliveryRequestView(),
        ),
        SliverToBoxAdapter(
          child: PaymentMethodView(),
        ),
        SliverToBoxAdapter(
          child: OrderProductView(),
        ),
        SliverToBoxAdapter(
          child: OrderPaymentView(),
        ),
        SliverToBoxAdapter(
          child: OutlinedButton(
            child: const Text('Purchase'),
            onPressed: () {
              print('purchase');
              // context.go(AppRouteConstant.payment);
              context.go('/cart/payment');
            },
            // style: TextButton.styleFrom(
            //   backgroundColor: Theme.of(context).primaryColor,
            //   foregroundColor: Theme.of(context).primaryColorLight,
            // ),
          ),
        )
      ],
    );
  }
}
