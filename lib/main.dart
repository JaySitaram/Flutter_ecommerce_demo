import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_demo/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_ecommerce_demo/pages/add_to_cart_screen.dart';
import 'package:flutter_ecommerce_demo/pages/product_listing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routing().generateRoute,
      initialRoute: 'product_listing',
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Routing{
  Route? generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case 'product_listing':
        return MaterialPageRoute(builder: ((context) => ProductPage()));
      case 'add_cart':
        return MaterialPageRoute(builder: (context) => AddCartScreen());
      default:
        return null;    
    }
  }
}