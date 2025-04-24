import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(product.imageUrl, height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20, color: Colors.green)),
                  SizedBox(height: 16),
                  Text(product.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addItem(product);
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Added to Cart'),
                            content: Text(
                                '${product.title} has been added to your cart.'),
                            actions: [
                              TextButton(
                                child: Text('View Cart'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Navigator.pushNamed(context, '/cart');
                                },
                              ),
                              TextButton(
                                child: Text('Continue Shopping'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addItem(product);
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Added to Cart'),
                            content: Text(
                                '${product.title} has been added to your cart.'),
                            actions: [
                              TextButton(
                                child: Text('View Cart'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Navigator.pushNamed(context, '/cart');
                                },
                              ),
                              TextButton(
                                child: Text('Continue Shopping'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
