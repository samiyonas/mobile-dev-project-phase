import 'package:flutter/material.dart';
import '../models/product.dart';
import 'add_product_page.dart';

class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({super.key, required this.product});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedSize = 41;
  final List<int> sizes = [39, 40, 41, 42, 43, 44];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildImageHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(),
                  const SizedBox(height: 24),
                  _buildSizeSelector(),
                  const SizedBox(height: 24),
                  _buildDescription(),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          widget.product.imageUrl,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.category,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '(${widget.product.rating})',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            itemBuilder: (context, index) {
              final size = sizes[index];
              final isSelected = size == selectedSize;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSize = size;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue[700] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected ? null : Border.all(color: Colors.grey[200]!),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    size.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.product.description,
      style: TextStyle(
        color: Colors.grey[600],
        height: 1.5,
        fontSize: 14,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'DELETE',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'UPDATE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
