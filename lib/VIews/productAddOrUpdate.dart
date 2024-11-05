import 'package:codetest/Models/productDTO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/productController.dart';

class ProductAddOrUpdatePage extends StatefulWidget {
  final ProductElement? product;
  const ProductAddOrUpdatePage({super.key, this.product});

  @override
  State<ProductAddOrUpdatePage> createState() => _ProductAddOrUpdatePageState();
}

class _ProductAddOrUpdatePageState extends State<ProductAddOrUpdatePage> {
  final ProductController controller = Get.find<ProductController>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addValue();
  }

  addValue() {
    nameCtrl.text = widget.product?.title.toString() ?? "";
    descCtrl.text = widget.product?.description.toString() ?? "";
    priceCtrl.text = widget.product?.price.toString() ?? "";
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  void createOrUpdateProduct() {
    if (formKey.currentState!.validate()) {
      ProductElement temp = widget.product ?? ProductElement();
      temp.title = nameCtrl.text;
      temp.description = descCtrl.text;
      temp.price = double.parse(priceCtrl.text);
      if (widget.product == null) {
        controller.products.insert(0, temp);
      } else {
        int index = controller.products
            .indexWhere((data) => data.id == widget.product?.id);
        if (index != -1) {
          controller.products[index] = temp;
        }
      }
      Get.back();
    } else {
      debugPrint("please fill form complete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product == null ? "Add Product" : "Update Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceCtrl,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: createOrUpdateProduct,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
