import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();

  final List<Product> cart = [
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
  ];

  double get totalAmount {
    return cart.fold(0, (sum, product) => sum + product.price);
  }

  bool _isProcessing = false;

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('M-Pesa Payment'),
        content: TextField(
          decoration: InputDecoration(
            labelText: 'Enter M-Pesa Phone Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
              _confirmOrder();
            },
            child: Text('Pay'),
          ),
        ],
      ),
    );
  }

  void _confirmOrder() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isProcessing = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OrderSuccessPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.green,
      ),
      body: _isProcessing
          ? Center(child: CircularProgressIndicator(color: Colors.green))
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Shipping Info
                    Text('Shipping Information',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Shipping Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter address' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter phone number' : null,
                    ),

                    SizedBox(height: 20),

                    // Payment Method
                    Text('Payment Method',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Column(
                        children: [
                          ListTile(
                            leading:
                                Icon(Icons.credit_card, color: Colors.green),
                            title: Text('Credit / Debit Card'),
                            onTap: () {},
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.monetization_on,
                                color: Colors.green),
                            title: Text('M-Pesa'),
                            onTap: _showPaymentDialog,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Order Summary
                    Text('Order Summary',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    ...cart.map((product) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(product.imageUrl,
                                  width: 60, height: 60),
                            ),
                            title: Text(product.name),
                            subtitle: Text(product.description),
                            trailing: Text('\$${product.price}',
                                style: TextStyle(color: Colors.green)),
                          ),
                        )),
                    Divider(),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _confirmOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child:
                          Text('Confirm Order', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// Simple Success Page
class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text('Order Placed Successfully!',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy Product Model
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
