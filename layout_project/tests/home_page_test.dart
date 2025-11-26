import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_project/pages/home_page.dart';


// Mock Product Model (required for data types)
class Product {
  final String name;
  final String category;
  final double price;
  final double rating;
  final String imageUrl;
  final String description;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.description,
  });
}

// Mock Product Card (used in your _buildProductList)
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // We only need a unique key and the name text for verification
    return Container(
      key: Key('productCard_${product.name}'),
      padding: const EdgeInsets.all(8.0),
      child: Text(product.name),
    );
  }
}

// Mock Add Product Page to simulate the navigation result
class MockAddProductPage extends StatelessWidget {
  const MockAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // This button simulates the successful completion of AddProductPage
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: const Key('mock_add_success_button'),
          onPressed: () {
            // Simulate adding a brand new product and returning it
            Navigator.pop(
              context,
              Product(
                name: 'New Test Sneaker', // Unique name to verify addition
                category: 'Test Category',
                price: 75.0,
                rating: 5.0,
                imageUrl: 'mock.png',
                description: 'mock description',
              ),
            );
          },
          child: const Text('Simulate Save'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Product List displays initial items and updates when a new product is added',
      (WidgetTester tester) async {
    // 1. Arrange & Act: Pump the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // --- A. Verify Initial Display ---

    // 1.1. Verify initial count (Your initial list has 2 products)
    expect(find.byType(ProductCard), findsNWidgets(2), 
        reason: 'Initial product count should be 2.');
    
    // 1.2. Verify the initial product text is present
    expect(find.text('Derby Leather Shoes'), findsNWidgets(2), 
        reason: 'Initial product name must be displayed twice.');


    // --- B. Simulate Product Addition ---

    // 2.1. Tap the Floating Action Button (FAB)
    await tester.tap(find.byType(FloatingActionButton));
    // Start the navigation transition
    await tester.pump(Duration.zero); 

    // Replace the route destination with our Mock page
    await tester.pumpWidget(const MaterialApp(
      home: MockAddProductPage(),
    ));
    // Settle the push transition
    await tester.pumpAndSettle(); 

    // 2.2. Click the button on the Mock page to simulate successful save and return (pop)
    await tester.tap(find.byKey(const Key('mock_add_success_button')));
    // Settle the pop transition AND the HomePage's setState call
    await tester.pumpAndSettle(); 


    // --- C. Verify Updated Display ---

    // 3.1. Assert: Product count has increased to 3
    expect(find.byType(ProductCard), findsNWidgets(3), 
        reason: 'Product count must increase to 3 after addition.');

    // 3.2. Assert: The new product is displayed automatically
    expect(find.text('New Test Sneaker'), findsOneWidget, 
        reason: 'The name of the newly added product must be visible.');
  });
}