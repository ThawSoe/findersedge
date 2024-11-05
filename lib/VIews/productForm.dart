// ignore_for_file: public_member_api_docs, sort_constructors_first
// views/product_form_page.dart
import 'package:flutter/material.dart';
import 'package:codetest/Models/productDTO.dart';

class ProductFormPage extends StatefulWidget {
  final ProductDTO? product;

  const ProductFormPage({
    super.key,
    this.product,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';

  String description = '';

  double price = 0.0;

  String imageUrl = '';

  void submitForm() {
    // Perform API call to create or update product
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.product?.total.toString() ?? '',
                onSaved: (value) => title = value!,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                initialValue: widget.product?.toString() ?? '',
                onSaved: (value) => description = value!,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                initialValue:
                    widget.product != null ? widget.product!.toString() : '',
                onSaved: (value) => price = double.parse(value!),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                initialValue: widget.product?.toString() ?? '',
                onSaved: (value) => imageUrl = value!,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
