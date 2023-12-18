
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatelessWidget {
  final String url;
 

  BookDetailPage({ required this.url });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ... display other book details ...

          ElevatedButton(
            onPressed: () {
              // Open the URL when the button is pressed
              launch(url);
            },
            child: Text('Open Book Details'),
          ),
        ],
      ),
    );
  }
}
