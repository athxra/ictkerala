import 'package:flutter/material.dart';
import 'package:api/services.dart';
import 'package:api/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final data = product.data;

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: product.imagePath != null
                        ? Image.asset(
                            product.imagePath!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                    title: Text(product.name),
                    subtitle: Text(data != null
                        ? 'Color: ${data.color ?? "N/A"}, Capacity: ${data.capacity ?? "N/A"}'
                        : 'No additional data'),
                    trailing: data != null && data.price != null
                        ? Text('\$${data.price!.toStringAsFixed(2)}')
                        : const Text('N/A'),

                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}