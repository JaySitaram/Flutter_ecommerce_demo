import 'dart:convert';
import 'dart:io';
import 'package:flutter_ecommerce_demo/models/product_model.dart';
import 'package:http/http.dart' as http;

class NetworkError extends Error {}

class ApiProvider {
  final String _url = 'http://205.134.254.135/~mobile/MtProject/public/api/product_list.php';

  Future<ProductModel> fetchList() async {
    try {
      final response = await http.get(Uri.parse(_url));
      return ProductModel.fromJson(json.decode(response.body));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductModel.withError("Data not found / Connection issue");
    }
  }
}

class ApiRepository {
  final _provider = ApiProvider();

  Future<ProductModel> fetchCovidList() {
    return _provider.fetchList();
  }
}