// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'VIews/productList.dart';

void main() {
  runApp(const CodeTest());
}

class CodeTest extends StatelessWidget {
  const CodeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Code Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const ProductListPage(),
    );
  }
}
