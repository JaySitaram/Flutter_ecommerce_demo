import 'package:flutter_ecommerce_demo/models/product_model.dart';

import '../../models/cart_model.dart';

abstract class CartState {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class SuccessCartState extends CartState{
  List<CartModel>? cartModel;

  SuccessCartState(this.cartModel);
}

class CartError extends CartState {
  final String? message;
  const CartError(this.message);
}
