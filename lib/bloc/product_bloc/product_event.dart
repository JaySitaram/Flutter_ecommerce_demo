import 'package:flutter_ecommerce_demo/models/product_model.dart';

abstract class ProductEvent {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductList extends ProductEvent {}

class AddProductList extends ProductEvent {
  Map<String,dynamic>? map;
  AddProductList(this.map);
}

class FetchProduct extends ProductEvent{}
