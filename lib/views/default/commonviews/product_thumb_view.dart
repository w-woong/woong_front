import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/views/default/components/imageview.dart';
import 'package:woong_front/views/default/product/product_detail_view.dart';
import 'package:go_router/go_router.dart';

class ProductThumbView extends StatefulWidget {
  final Product product;
  const ProductThumbView({super.key, required this.product});

  @override
  State<ProductThumbView> createState() => _ProductThumbViewState();
}

class _ProductThumbViewState extends State<ProductThumbView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    widget.product.imgUrl,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class ProductThumbWithBottom extends StatefulWidget {
  final Product product;
  final String path;
  const ProductThumbWithBottom(
      {super.key, required this.product, required this.path});

  @override
  State<ProductThumbWithBottom> createState() => _ProductThumbWithBottomState();
}

class _ProductThumbWithBottomState extends State<ProductThumbWithBottom> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Container(
            // width: 120,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('${widget.path}/product', extra: widget.product);

                    // showCupertinoModalBottomSheet(
                    //   context: context,
                    //   expand: false,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (context) {
                    //     return ProductDetailView(
                    //       product: widget.product,
                    //       isSheet: true,
                    //     );
                    //   },
                    // );
                  },
                  // child: ImageView(),
                  child: Image.network(
                    widget.product.imgUrl,
                    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    fit: BoxFit.cover,
                    height: constraints.maxWidth,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              '₩ ${widget.product.priceWithCommas}',
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // return Container(
    //   // width: 120,
    //   // color: Colors.red,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     // crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           // context.go('/shopping/product');

    //           // showCupertinoModalBottomSheet(
    //           //   context: context,
    //           //   expand: false,
    //           //   useRootNavigator: true,
    //           //   backgroundColor: Colors.transparent,
    //           //   builder: (context) {
    //           //     return ProductDetailView();
    //           //   },
    //           // );
    //         },
    //         // child: ImageView(),
    //         child: Image.network(
    //           // widget.product.imgUrl,
    //           'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    //           fit: BoxFit.cover,
    //           height: MediaQuery.of(context).size.width,
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.all(2),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: Text(
    //                     widget.product.name,
    //                     style: Theme.of(context).textTheme.titleLarge,
    //                     maxLines: 1,
    //                     softWrap: false,
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Expanded(
    //                   child: Text(
    //                     '₩ ${widget.product.price}',
    //                     style: Theme.of(context).textTheme.titleLarge,
    //                     maxLines: 1,
    //                     softWrap: false,
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
