import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';
import 'package:woong_front/domains/order/viewmodel/cart_vm.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/views/default/identity/login_sheet_view.dart';

class BottomBar extends StatefulWidget {
  final Product product;
  final bool isSheet;
  const BottomBar({super.key, required this.isSheet, required this.product});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var cart = context.select((CartVM vm) => vm.myCart);

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      // color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                child: Text('Cart'),
                onPressed: () async {
                  try {
                    await context.read<CartVM>().add(CartProduct.withProduct(
                        cart.id, widget.product, 1, widget.product.price));
                  } on UnauthorizedException {
                    showCupertinoModalBottomSheet(
                      context: context,
                      expand: false,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return LoginSheetView();
                      },
                    ).then((value) async {
                      try {
                        await context.read<CartVM>().add(
                            CartProduct.withProduct(cart.id, widget.product, 1,
                                widget.product.price));
                      } catch (e) {
                        print(e);
                        return;
                      }
                    });

                    return;
                  } catch (e) {
                    print(e);
                    return;
                  }

                  if (widget.isSheet) {
                    Navigator.pop(context);
                    return;
                  }
                  context.go(AppRouteConstant.shopping);
                },
                // style: TextButton.styleFrom(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   foregroundColor: Theme.of(context).primaryColorLight,
                // ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: OutlinedButton(
                child: const Text('Purchase'),
                onPressed: () {
                  if (widget.isSheet) {
                    Navigator.pop(context);
                    return;
                  }
                },
                // style: TextButton.styleFrom(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   foregroundColor: Theme.of(context).primaryColorLight,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
