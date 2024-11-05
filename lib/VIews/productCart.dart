import 'package:codetest/Controllers/productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCartPage extends StatefulWidget {
  const ProductCartPage({super.key});

  @override
  State<ProductCartPage> createState() => _ProductCartPageState();
}

class _ProductCartPageState extends State<ProductCartPage> {
  final ProductController controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.cartProducts.length,
          itemBuilder: (context, index) {
            final product = controller.cartProducts[index];
            final inCart = controller.cartProducts.contains(product);
            return ListTile(
              title: Text(product.title.toString()),
              subtitle: Text(product.description.toString()),
              trailing: IconButton(
                icon: Icon(
                  inCart
                      ? Icons.remove_circle_outline
                      : Icons.add_circle_outline,
                  color: inCart ? Colors.red : Colors.green,
                ),
                onPressed: () {
                  inCart
                      ? controller.removeFromCart(product)
                      : controller.addToCart(product);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
