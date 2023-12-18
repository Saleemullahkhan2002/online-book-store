import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/cart_provider.dart';
import 'package:task/view/home_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
        child: Builder(builder: (BuildContext context) {
          
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeView(),
          );
        }));
  }
}
