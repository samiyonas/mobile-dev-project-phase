import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_project/pages/add_product_page.dart';

void main() {
  testWidgets('Add Product Page Test', (WidgetTester tester) async {
    // Build the AddProductPage widget
    await tester.pumpWidget(MaterialApp(home: AddProductPage()));

    // Verify that the initial UI elements are present
    expect(find.text('Add Product'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4)); 
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Enter product details
    await tester.enterText(find.byKey(Key('nameField')), 'Test Product');
    await tester.enterText(find.byKey(Key('categoryField')), 'Shoe');
    await tester.enterText(find.byKey(Key('priceField')), '19.99');
    await tester.enterText(find.byKey(Key('descriptionField')), 'This is a test product.');

    // Tap the 'Add Product' button
    await tester.tap(find.byKey(Key('addProductButton')));
    await tester.pumpAndSettle();

    // Verify that the product was added and the page is popped
    expect(find.byType(AddProductPage), findsNothing);
  });
}