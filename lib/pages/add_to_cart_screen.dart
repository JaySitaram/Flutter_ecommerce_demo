import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_demo/bloc/product_bloc/product_event.dart';
import 'package:flutter_ecommerce_demo/models/cart_model.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_state.dart';

class AddCartScreen extends StatefulWidget {
  const AddCartScreen({Key? key}) : super(key: key);

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  CartBloc? productBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc=BlocProvider.of<CartBloc>(context);
    productBloc!.add(FetchCart());
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              print('get-> $state');
              if (state is CartInitial) {
                return _buildLoading();
              } else if (state is CartLoading) {
                return _buildLoading();
              } else if (state is SuccessCartState) {
                return _buildCard(context, state.cartModel!);
              } else if (state is CartError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        );
  }

  Widget _buildCard(BuildContext context, List<CartModel> model) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical:5,horizontal: 10),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: ListTile(
                  leading: Image.network(model[index].image??""),
                  title: Text(model[index].title!,maxLines: 4,overflow: TextOverflow.ellipsis,),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('Price')),
                          Text(model[index].price!,maxLines: 4,overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                       Row(
                        children: [
                          Expanded(child: Text('Quantity')),
                          Text(model[index].qty!,maxLines: 4,overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        );
     }));
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}