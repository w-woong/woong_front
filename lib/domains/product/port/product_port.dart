import 'package:woong_front/domains/product/model/product.dart';

abstract class ProductDetailService {
  Future<Product> findProductDetail(String id);
}
