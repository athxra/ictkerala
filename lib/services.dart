import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

Future<List<Product>> fetchProducts() async {
  final url = Uri.parse('https://api.restful-api.dev/objects'); // Replace with your API
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}