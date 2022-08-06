import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_demo/bloc/product_bloc/product_event.dart';
import 'package:flutter_ecommerce_demo/bloc/product_bloc/product_state.dart';
import 'package:flutter_ecommerce_demo/repository/sqflite_service.dart';

import '../../models/cart_model.dart';
import '../../repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetProductList>((event, emit) async {
      try {
        emit(ProductLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(ProductLoaded(mList));
        if (mList.error != null) {
          emit(ProductError(mList.error));
        }
      } on NetworkError {
        emit(ProductError("Failed to fetch data. is your device online?"));
      }
    });

    on<AddProductList>((event,emit){
      DbNoteService().insertProduct(event.map!);
    });
  }
}
