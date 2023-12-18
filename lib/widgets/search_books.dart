import 'package:flutter/material.dart';
import 'package:task/models/product_model.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

class BookSearchDelegate extends SearchDelegate<String> {
  final List<BooksModel> books;

  BookSearchDelegate({required this.books});

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear text)
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar (e.g., back arrow)
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the search results based on the query
    final results = books
        .where((book) =>
            book.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].title ?? ''),
          subtitle: Text(results[index].author ?? ''),
          onTap: () {
            // Open the URL when a search result is tapped
            launch(results[index].url ?? '');
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types in the search bar
    final suggestions = books
        .where((book) =>
            book.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].title ?? ''),
          subtitle: Text(suggestions[index].author ?? ''),
          onTap: () {
            // Open the URL when a suggestion is tapped
            launch(suggestions[index].url ?? '');
          },
        );
      },
    );
  }
}
