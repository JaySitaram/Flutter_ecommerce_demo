import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_demo/bloc/cart_bloc/cart_state.dart';
import 'package:flutter_ecommerce_demo/bloc/product_bloc/product_event.dart';
import 'package:flutter_ecommerce_demo/bloc/product_bloc/product_state.dart';
import 'package:flutter_ecommerce_demo/repository/sqflite_service.dart';

import '../../models/cart_model.dart';
import '../../repository/product_repository.dart';
import 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<FetchCart>(((event, emit) async {
      emit(CartLoading());
      List<CartModel> cartModel=[];
      final data=await DbNoteService().selectProduct();
      print(data);
      for(var item in data){
        cartModel.add(CartModel.fromJson(item));
      }
      emit(SuccessCartState(cartModel));
    }));
  }
}
