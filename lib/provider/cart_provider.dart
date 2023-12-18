import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<String> _cartItems = [];

  List<String> get cartItems => _cartItems;

  // SharedPreferences key for storing cart items
  static const String cartKey = 'cart_items';

  CartProvider() {
    // Load cart items from SharedPreferences when the provider is created
    _loadCartFromPreferences();
  }

  void addToCart(String bookTitle) {
    _cartItems.add(bookTitle);
    notifyListeners();
    _saveCartToPreferences(); // Save cart items to SharedPreferences
  }

  void removeFromCart(String bookTitle) {
    _cartItems.remove(bookTitle);
    notifyListeners();
    _saveCartToPreferences(); // Save cart items to SharedPreferences
  }

  bool isInCart(String bookTitle) {
    return _cartItems.contains(bookTitle);
  }

  // Helper method to load cart items from SharedPreferences
  Future<void> _loadCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getStringList(cartKey) ?? [];
    _cartItems = cartItems;
    notifyListeners();
  }

  // Helper method to save cart items to SharedPreferences
  Future<void> _saveCartToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(cartKey, _cartItems);
  }
}
