import 'package:flutter_ecommerce_demo/models/product_model.dart';

abstract class CartEvent {
  const CartEvent();

  @override
  List<Object> get props => [];
}


class FetchCart extends CartEvent{}
