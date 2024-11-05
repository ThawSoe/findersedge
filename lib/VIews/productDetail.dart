// views/product_detail_page.dart
import 'package:codetest/Models/productDTO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/productController.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductElement product;
  final ProductController controller = Get.find();

  ProductDetailPage({super.key, required this.product});

  void confirmDeletion(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == true) {
      controller.deleteProduct(product.id ?? 0);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Delete",
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => confirmDeletion(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(product.title.toString(),
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text('\$${product.price}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text(product.description.toString(),
                style: const TextStyle(fontSize: 16)),
            Image.network(product.thumbnail.toString()),
          ],
        ),
      ),
    );
  }
}
