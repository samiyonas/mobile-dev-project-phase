/*
Products will have the following properties:
Name
Description
Price
Image
To create the eCommerce application, you will need to:
Create a class representing a product with the above properties
Create a class that manages products, which should include methods to:
Add a new product
View all products
View only completed products
View only pending products
Edit a product (update name, description, price, Image)
*/
import 'dart:io';

class Product {
  String name;
  String description;
  double price;
  String image;
  int id;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  }) : id = 0;

}

class ProductManager {
  List<Product> _products = [];
  int _nextId = 1;

  void _addProduct(Product product) {
    product.id = _nextId++;
    _products.add(product);
    print('Product added: ${product.name}');
  }

  void viewAllProducts() {
    for (final product in _products) {
      print('ID: ${product.id}, Name: ${product.name}, Description: ${product.description}, Price: ${product.price}, Image: ${product.image}');
    }
  }

  void viewProductById(int id) {
    for (final product in _products) {
      if (product.id == id) {
        print('ID: ${product.id}, Name: ${product.name}, Description: ${product.description}, Price: ${product.price}, Image: ${product.image}');
        return;
      }
    }
  }

  void editProduct(int id, String? name, String? description, double? price, String? image) {
    for (final product in _products) {
      if (product.id == id) {
        if (name != null) product.name = name;
        if (description != null) product.description = description;
        if (price != null) product.price = price;
        if (image != null) product.image = image;
        return;
      }
    }
    print('Product with ID $id not found.');
  }

  void deleteProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    print('Product with ID $id deleted.');
  }
}

void main() {
  final productManager = ProductManager();

  while (true) {
     print('1. Add Product');
     print('2. View All Products');
     print('3. View Product by ID');
     print('4. Edit Product');
     print('5. Delete Product');
     print('6. Exit');
     stdout.write('Choose an option: ');
     final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          stdout.write('Enter product name: ');
          final name = stdin.readLineSync()!;
          stdout.write('Enter product description: ');
          final description = stdin.readLineSync()!;
          stdout.write('Enter product price: ');
          final price = double.parse(stdin.readLineSync()!);
          stdout.write('Enter product image URL: ');
          final image = stdin.readLineSync()!;
          final product = Product(name: name, description: description, price: price, image: image);
          productManager._addProduct(product);
          break;
        case '2':
          productManager.viewAllProducts();
          break;
        case '3':
          stdout.write('Enter product ID: ');
          final id = int.parse(stdin.readLineSync()!);
          productManager.viewProductById(id);
          break;
        case '4':
          stdout.write('Enter product ID to edit: ');
          final id = int.parse(stdin.readLineSync()!);
          stdout.write('Enter new name (or press enter to skip): ');
          final name = stdin.readLineSync();
          stdout.write('Enter new description (or press enter to skip): ');
          final description = stdin.readLineSync();
          stdout.write('Enter new price (or press enter to skip): ');
          final priceInput = stdin.readLineSync();
          final price = priceInput!.isEmpty ? null : double.parse(priceInput);
          stdout.write('Enter new image URL (or press enter to skip): ');
          final image = stdin.readLineSync();
          productManager.editProduct(id, name!.isEmpty ? null : name, description!.isEmpty ? null : description, price, image!.isEmpty ? null : image);
          break;
        case '5':
          stdout.write('Enter product ID to delete: ');
          final id = int.parse(stdin.readLineSync()!);
          productManager.deleteProduct(id);
          break;
        case '6':
          return;
        default:
          print('Invalid choice. Please try again.');
      }
  }
}