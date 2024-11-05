// views/product_list_page.dart
import 'package:codetest/Core/core_enum.dart';
import 'package:codetest/VIews/productAddOrUpdate.dart';
import 'package:codetest/VIews/productCart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/productController.dart';
import 'productDetail.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            tooltip: "Filter By Category",
            onSelected: (String category) {
              controller.filterProducts(category);
            },
            itemBuilder: (BuildContext context) {
              return controller.categoryFilter?.map((category) {
                    return PopupMenuItem<String>(
                      value: category,
                      child: Text(category.toString()),
                    );
                  }).toList() ??
                  [];
            },
            icon: const Icon(Icons.filter_list, color: Colors.orange),
          ),
          PopupMenuButton<SortOption>(
            tooltip: "Sort By Price",
            onSelected: (SortOption category) {
              controller.sortOption.value = category;
              controller.sortProducts();
            },
            itemBuilder: (BuildContext context) {
              return SortOption.values.map((category) {
                return PopupMenuItem<SortOption>(
                  value: category,
                  child: Text(category.toString()),
                );
              }).toList();
            },
            icon: const Icon(Icons.sort, color: Colors.red),
          ),
          IconButton(
            tooltip: "Shopping Cart",
            icon: const Icon(Icons.shopping_cart, color: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductCartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.tempProducts.length,
          itemBuilder: (context, index) {
            final product = controller.tempProducts[index];
            final inCart = controller.cartProducts.contains(product);
            return Card(
              color: inCart ? Colors.white : Colors.white60,
              child: ListTile(
                title: Text(product.title.toString()),
                subtitle: Text(
                  product.description.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                dense: true,
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
                onTap: () {
                  Get.to(() => ProductDetailPage(product: product));
                },
                onLongPress: () {
                  Get.to(() => ProductAddOrUpdatePage(product: product));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ProductAddOrUpdatePage());
        },
        tooltip: 'New Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
