import 'package:flutter_ecommerce_demo/models/product_model.dart';

import '../../models/cart_model.dart';

abstract class ProductState {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  ProductModel? productModel;
  ProductLoaded(this.productModel);
}

class ProductError extends ProductState {
  final String? message;
  const ProductError(this.message);
}
