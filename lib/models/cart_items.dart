import 'package:task/models/product_model.dart';

class CartItem {
  final BooksModel book;
  int quantity;

  CartItem({required this.book, this.quantity = 1});
}