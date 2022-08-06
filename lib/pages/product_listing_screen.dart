import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_event.dart';
import '../bloc/product_bloc/product_state.dart';
import '../models/product_model.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductBloc _newsBloc = ProductBloc();

  @override
  void initState() {
    _newsBloc.add(GetProductList());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Mall'),actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed("add_cart");
        }, icon: Icon(Icons.shopping_cart))
      ]),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider<ProductBloc>(
        create: (_) => _newsBloc,
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                return _buildLoading();
              } else if (state is ProductLoading) {
                return _buildLoading();
              } else if (state is ProductLoaded) {
                return _buildCard(context, state.productModel!);
              } else if (state is ProductError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, ProductModel model) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: model.data!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical:5,horizontal: 10),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Image.network(model.data![index].featuredImage??"")),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                           children: [
                            Expanded(child: Text(model.data![index].title!,maxLines: 4,overflow: TextOverflow.ellipsis,)),
                            GestureDetector(
                              onTap: (){
                                _newsBloc.add(AddProductList({
                                  'image':model.data![index].featuredImage,
                                  'product_name':model.data![index].title,
                                  'product_price':model.data![index].price.toString(),
                                  'product_qty':model.data![index].slug.toString(),
                                }));
                              },
                              child: Icon(Icons.shopping_cart))
                           ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
     });
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
