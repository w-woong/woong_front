import 'package:woong_front/domains/order/model/cart.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';

abstract class CartService {
  Future<Cart> findCart();
  Future<CartProduct> addCartProduct(CartProduct cartProduct);
  Future<Cart> testRefreshError();
}

abstract class FetchCartVM {
  Future<void> fetch();
  Future<void> testRefreshError();
}

abstract class AddCartVM {
  Future<void> add(CartProduct cartProduct);
}
