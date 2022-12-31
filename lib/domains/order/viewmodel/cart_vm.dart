import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woong_front/domains/order/model/cart.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';
import 'package:woong_front/domains/order/port/cart_port.dart';

class CartVM extends ChangeNotifier implements FetchCartVM, AddCartVM {
  CartService svc;

  Cart myCart;
  CartVM(this.svc) : myCart = Cart.empty();

  @override
  Future<void> fetch() async {
    try {
      myCart = await svc.findCart();
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> add(CartProduct cartProduct) async {
    try {
      var addedCartProduct = await svc.addCartProduct(cartProduct);
      myCart.addCartProduct(addedCartProduct);
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> testRefreshError() async {
    try {
      await svc.testRefreshError();
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
