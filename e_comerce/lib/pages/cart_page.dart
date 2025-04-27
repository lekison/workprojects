import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Product {
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  Product(
      {required this.imageUrl,
      required this.name,
      required this.description,
      required this.price});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartPage(),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products = [
    Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        price: 20.0),
    Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 2',
        description: 'Description of Product 2',
        price: 30.0),
    Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 3',
        description: 'Description of Product 3',
        price: 40.0),
  ];

  final List<Product> relatedProducts = [
    Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Related Product 1',
        description: 'Related to Product 1',
        price: 15.0),
    Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Related Product 2',
        description: 'Related to Product 2',
        price: 25.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Your Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Product List
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    child: ListTile(
                      leading: Image.network(product.imageUrl,
                          width: 60, height: 60),
                      title: Text(product.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(product.description),
                      trailing: Column(
                        children: [
                          Text('\$${product.price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Remove item from cart
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Related Products
              SizedBox(height: 16),
              Text('You may also like',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedProducts.length,
                  itemBuilder: (context, index) {
                    final relatedProduct = relatedProducts[index];
                    return Card(
                      margin: EdgeInsets.only(right: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      child: Column(
                        children: [
                          Image.network(relatedProduct.imageUrl,
                              width: 100, height: 100),
                          Text(relatedProduct.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('\$${relatedProduct.price}',
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Delivery Information
              SizedBox(height: 16),
              Text('Delivery Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estimated Delivery Time: 3-5 Days',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Shipping: Free', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),

              // Payment Methods
              SizedBox(height: 16),
              Text('Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.credit_card, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Credit Card / Debit Card',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.monetization_on, color: Colors.green),
                          SizedBox(width: 8),
                          Text('M-Pesa', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Proceed to Checkout
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Proceed to checkout
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Accent color
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                child:
                    Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
