// pages/product_details_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trogon_machine_test_2/models/model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({super.key, required this.product});

  final RxBool isFavorite = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  isFavorite.value ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  isFavorite.toggle();
                  if (isFavorite.value) {
                    Get.snackbar('Favorite', 'Added to favorites!');
                  } else {
                    Get.snackbar('Favorite', 'Removed from favorites!');
                  }
                },
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Image.network(
              product.image,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Display placeholder or error image when loading fails
                return Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 50,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // Product Name
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Brand and Category
            Text('Brand: ${product.brand}'),
            Text('Category: ${product.category}'),
            // Availability
            Text(
              product.availability ? 'In Stock' : 'Out of Stock',
              style: TextStyle(
                color: product.availability ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Price and Discount
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
            Text(
              'Discounted Price: \$${(product.price * (1 - product.discount / 100)).toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 24),
                const SizedBox(width: 4),
                Text('${product.rating}/5'),
              ],
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              'Description',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 16),
            // Add to Cart Button
            ElevatedButton.icon(
              onPressed: () {
                Get.snackbar('Cart', 'Added to cart!');
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
            ),
          ],
        ),
      ),
    );
  }
}
