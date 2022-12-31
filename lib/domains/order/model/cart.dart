import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'created_at', toJson: JsonUtils.dateTimeToJson)
  DateTime createdAt;
  @JsonKey(name: 'updated_at', toJson: JsonUtils.dateTimeToJson)
  DateTime updatedAt;
  @JsonKey(name: 'user_id', fromJson: JsonUtils.stringFromJson)
  String userID;

  @JsonKey(name: 'cart_products')
  List<CartProduct>? cartProducts;

  // static List<CartProduct> _productsFromJson(List<CartProduct>? json) {
  //   return json ?? [];
  // }

  Cart({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userID,
    required this.cartProducts,
  });

  Cart.empty()
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        userID = '',
        cartProducts = [];

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  void addCartProduct(CartProduct cartProduct) {
    cartProducts?.add(cartProduct);
  }
}
