import 'dart:convert';
import 'package:elevate_task/Home/product_model.dart';
import 'package:http/http.dart' as http;


Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Product.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
