import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
import 'package:woong_front/domains/order/viewmodel/cart_vm.dart';
import 'package:woong_front/views/default/cart/contents/cart_product_view.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/views/default/components/imageview.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/views/default/identity/login_sheet_view.dart';

class CartView extends StatefulWidget {
  final String title;
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const CartView({super.key, required this.bottomTabs, required this.title});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    context.read<CartVM>().fetch().catchError(
      (e) {
        showCupertinoModalBottomSheet(
          context: context,
          expand: false,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return LoginSheetView();
          },
        ).then((value) => context.go('/home'));
      },
      test: (e) => e is UnauthorizedException,
    ).catchError(
      (e) {
        print(e);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _CartBody(title: widget.title)),
      bottomNavigationBar: BottomNavV2(tabs: widget.bottomTabs),
    );
  }
}

class _CartBody extends StatefulWidget {
  final String title;
  const _CartBody({super.key, required this.title});

  @override
  State<_CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<_CartBody> {
  @override
  Widget build(BuildContext context) {
    int numCols = 1;
    var cart = context.select((CartVM vm) => vm.myCart);
    var cartProducts = cart.cartProducts ?? [];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            DefaultAppBar(
                title: widget.title, showCart: true, showAccount: true),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       print(constraints);
            //       return CartProductView(
            //         width: constraints.maxWidth,
            //         cartProduct: cartProducts[index],
            //       );
            //     },
            //     childCount: cartProducts.length,
            //   ),
            // ),
            cartProducts.isEmpty
                ? SliverToBoxAdapter(
                    child: Container(),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: constraints.maxWidth / numCols,
                        mainAxisExtent: 300,
                        mainAxisSpacing: 10.0,
                        // crossAxisSpacing: 10.0,
                        // childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            child: CartProductView(
                              width: constraints.maxWidth - 20,
                              cartProduct: cartProducts[index],
                            ),
                          );
                        },
                        childCount: cartProducts.length,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
