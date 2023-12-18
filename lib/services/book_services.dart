// services/book_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class BookService {
  static const String apiUrl = 'https://wolnelektury.pl/api/books/';

  Future<List<BooksModel>> getBooks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => BooksModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
