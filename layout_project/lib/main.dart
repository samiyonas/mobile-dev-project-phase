import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import '../pages/add_product_page.dart';
import '../pages/search_page.dart';
import '../pages/details_page.dart';
import '../models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Assuming default font or one available
        useMaterial3: true,
      ),
      home: HomePage(),
      initialRoute: '/',
      routes: {
        '/add_product': (context) => const AddProductPage(),
        '/search': (context) => const SearchPage(),
        '/details': (context) => DetailsPage(
          product: Product(
            name: 'Nike',
            category: 'Shoe',
            price: 0.0,
            rating: 0.0,
            imageUrl: '',
            description: '',
          ),
        ),
      },
    );
  }
}
