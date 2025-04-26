import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), elevation: 2.0),
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          return cartModel.cartItems.isEmpty
              ? Center(child: Text('Your cart is empty'))
              : ListView.builder(
                itemCount: cartModel.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartModel.cartItems[index];
                  return ListTile(
                    leading: Image.asset(product.imageUrl),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        cartModel.removeFromCart(product);
                      },
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}
