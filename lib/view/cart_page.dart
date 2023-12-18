import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart.cartItems[index]),
              );
            },
          );
        },
      ),
    );
  }
}
