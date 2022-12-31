import 'package:flutter/material.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';
import 'package:woong_front/domains/order/viewmodel/cart_vm.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:provider/provider.dart';

class MyTestView extends StatefulWidget {
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const MyTestView({super.key, required this.bottomTabs});

  @override
  State<MyTestView> createState() => _MyTestViewState();
}

class _MyTestViewState extends State<MyTestView> {
  @override
  Widget build(BuildContext context) {
    var cart = context.select((CartVM vm) => vm.myCart);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Test View',
                        style: Theme.of(context).textTheme.headline2),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await context.read<CartVM>().fetch();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('FetchCart'),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          var product = Product.empty();
                          product.id = 'test-product-id-0001';
                          product.price = 1000;
                          await context.read<CartVM>().add(
                              CartProduct.withProduct(cart.id, product, 1, 1));
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('FetchCart'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavV2(
        tabs: widget.bottomTabs,
      ),
    );
  }
}
