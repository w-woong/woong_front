import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/product/product.dart';

class DynamicProductsView extends StatefulWidget {
  const DynamicProductsView({super.key});

  @override
  State<DynamicProductsView> createState() => _DynamicProductsViewState();
}

class _DynamicProductsViewState extends State<DynamicProductsView> {
  @override
  Widget build(BuildContext context) {
    List<Product> products =
        context.select((ProductVM value) => value.products);

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  '상품',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            child: GridView(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                // childAspectRatio: 3 / 2,
                // crossAxisSpacing: 20,
                // mainAxisSpacing: 20,
              ),
              children: getItems(products),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getItems(List<Product> list) {
    return list.map((item) => ProductView(product: item)).toList();
  }
}

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    product.imgUrl,
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
                    child: const Text(
                      'No. image',
                      style: TextStyle(
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
