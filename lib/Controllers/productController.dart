// controllers/product_controller.dart
import 'package:codetest/Core/core_enum.dart';
import 'package:codetest/Models/productDTO.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<ProductElement> products = <ProductElement>[].obs;
  RxList<ProductElement> tempProducts = <ProductElement>[].obs;
  RxList<ProductElement> cartProducts = <ProductElement>[].obs;
  RxBool isLoading = true.obs;
  Rx<SortOption> sortOption = SortOption.ascending.obs;
  final dio = Dio();
  List<String?>? categoryFilter = <String>[];

  @override
  void onInit() {
    fetchProducts();
    super.onInit();

    // ever(sortOption, (data) => sortProducts());
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        ProductDTO a = ProductDTO.fromJson(response.data);
        products.value = a.products ?? [];
        //continiue
        tempProducts.value = products;
        categoryFilter = products.map((data) => data.category).toSet().toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void filterProducts(String category) {
    List<ProductElement> temp = <ProductElement>[];
    for (var data in products) {
      if (data.category == category) {
        temp.add(data);
      }
    }
    tempProducts.value = temp;
  }

  void sortProducts() {
    tempProducts.sort((a, b) => SortOption.ascending == sortOption.value
        ? a.price!.compareTo(b.price as num)
        : b.price!.compareTo(a.price as num));
  }

  void addToCart(ProductElement product) {
    cartProducts.add(product);
    tempProducts.refresh();
  }

  void removeFromCart(ProductElement product) {
    cartProducts.remove(product);
    tempProducts.refresh();
  }

  Future<void> deleteProduct(int id) async {
    tempProducts.removeWhere((product) => product.id == id);
    // Call delete API if needed.
  }
}
