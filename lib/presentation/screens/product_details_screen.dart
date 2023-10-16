import 'package:e_commerce_test/data/models/all_products_response.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      widget.product.image,
                      alignment: Alignment.center,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Colors.orangeAccent.withOpacity(0.3)),
                      onPressed: () {},
                      child: Text(
                        '⭐️ ${widget.product.rating.rate}',
                        style: const TextStyle(color: Colors.orangeAccent),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "NGN ${widget.product.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black),
                      onPressed: () {},
                      child: const Text("Add to cart")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
