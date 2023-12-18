import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:task/models/product_model.dart';
import 'package:task/provider/cart_provider.dart';
import 'package:task/view/cart_page.dart';
import 'package:task/widgets/search_books.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Book_details.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
void _showSearchBar(BuildContext context) async {
  final result = await showSearch<String>(
    context: context,
    delegate: BookSearchDelegate(books: postList),
  );

  // Handle the search result if needed
  if (result != null && result.isNotEmpty) {
    // Do something with the result if needed
  }
}




  List<BooksModel> postList = [];

  Future<List<BooksModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://wolnelektury.pl/api/books/?format=json'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      for (Map<String, dynamic> i in data) {
        postList.add(BooksModel.fromJson(i));
      }

      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
  final cartProvider = Provider.of<CartProvider>(context); // Declare cartProvider here

    return Scaffold(
      appBar:AppBar(
  title: IconButton(
      onPressed: () => _showSearchBar(context),
      icon: Icon(Icons.search),
    ),
  actions: [
    IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart page or show a modal
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
            },
          ),
  ],
),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                          // Open the URL directly when the book is tapped
                          launch(postList[index].url ?? '');
                        },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [ Row(children: [

                                        Image.network(
                        'https://wolnelektury.pl/media/${postList[index].cover ?? ''}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Image.asset('assets/placeholder_image.jpg'); // Replace with your placeholder image asset
                        },
                      ), 
                      SizedBox( width: MediaQuery.of(context).size.height*.01,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                          
                                                   
                                // Text("Title: ${postList[index].title ?? ''}", ),
                                Text(
        "Title: ${postList[index].title ?? ''}",
        maxLines: 2, // Set the maximum number of lines
        overflow: TextOverflow.ellipsis, // Handle overflow by displaying ellipsis
        style: TextStyle(
          fontWeight: FontWeight.bold,
           fontSize: MediaQuery.of(context).size.longestSide*.01,
        ),
      ),
        Text(
        "Author: ${postList[index].author ?? ''}",
        maxLines: 2, // Set the maximum number of lines
        overflow: TextOverflow.ellipsis, // Handle overflow by displaying ellipsis
        style: TextStyle(
          fontWeight: FontWeight.bold,
           fontSize: MediaQuery.of(context).size.longestSide*.01,
        ),
      ),
                                // Text("Author: ${postList[index].author ?? ''}"),
                               IconButton(
                                          icon: Icon(
                                            cartProvider.isInCart(postList[index].title!)
                                                ? Icons.shopping_cart
                                                : Icons.add_shopping_cart,
                                            color: cartProvider.isInCart(postList[index].title!)
                                                ? Colors.green
                                                : null,
                                          ),
                                          onPressed: () {
                                            if (cartProvider.isInCart(postList[index].title!)) {
                                              cartProvider.removeFromCart(postList[index].title!);
                                            } else {
                                              cartProvider.addToCart(postList[index].title!);
                                            }
                                          },
                                        ),
                         
                       ],),
                       
                              ],),
                      
                            
                      
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
