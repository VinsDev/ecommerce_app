import 'package:ecommerce_app/data/products_data.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Product> productsList = products;
  List<Product> filteredProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
      _filterProducts(_searchController.text);
    });
    filteredProducts = productsList;
  }

  void _filterProducts(String query) {
    final results =
        productsList
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), elevation: 2.0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products . . .',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 10),
              filteredProducts.isEmpty
                  ? Center(child: Text('Product not found . . .'))
                  : Expanded(
                    child: GridView.builder(
                      itemCount: filteredProducts.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder:
                          (context, index) =>
                              ProductCard(product: filteredProducts[index]),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
