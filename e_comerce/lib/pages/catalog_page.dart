import 'dart:async';
import 'package:e_comerce/pages/cart_page.dart';
import 'package:e_comerce/pages/checkout_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Homepage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> categories = [
    {'name': 'Electronics', 'icon': Icons.electrical_services},
    {'name': 'Fashion', 'icon': Icons.checkroom},
    {'name': 'Home', 'icon': Icons.home},
    {'name': 'Beauty', 'icon': Icons.brush},
    {'name': 'Sports', 'icon': Icons.sports_soccer},
  ];

  List<Map<String, dynamic>> products = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1606813902919-6462c13101bb?auto=format&fit=crop&w=800&q=80',
      'name': 'Nike Air Max',
      'price': 129.99,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80',
      'name': 'Smart Watch',
      'price': 199.99,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1600185365605-3c9235b79c4d?auto=format&fit=crop&w=800&q=80',
      'name': 'Leather Handbag',
      'price': 89.99,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1580910051074-c02d1e5f8ba5?auto=format&fit=crop&w=800&q=80',
      'name': 'Running Shoes',
      'price': 99.99,
    },
  ];

  late Timer _timer;
  Duration _offerDuration = Duration(hours: 3, minutes: 24, seconds: 0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_offerDuration.inSeconds > 0) {
          _offerDuration -= Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get formattedTimer {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_offerDuration.inHours);
    final minutes = twoDigits(_offerDuration.inMinutes.remainder(60));
    final seconds = twoDigits(_offerDuration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search products...",
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutPage()),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.green),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 15, 192, 9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1618354691344-9ee7c7c9c7ad?auto=format&fit=crop&w=800&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text(
                      'Super Sale!\nUp to 50% Off',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black54,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Special Offers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text('Special Offers',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('Ends in $formattedTimer',
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 140,
              padding: EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return OfferCard(
                      title: category['name'], icon: category['icon']);
                },
              ),
            ),

            // Categories
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    categories.map((cat) => CategoryChip(cat['name'])).toList(),
              ),
            ),

            // Product Sections
            ...categories.map((category) {
              return ProductSection(
                title: category['name'],
                products: products,
              );
            }).toList(),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Side Menu
class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30, backgroundColor: Colors.white),
                SizedBox(height: 8),
                Text('Welcome, User',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text('Home')),
          ListTile(leading: Icon(Icons.shopping_bag), title: Text('Orders')),
          ListTile(leading: Icon(Icons.shopping_cart), title: Text('Cart')),
          ListTile(leading: Icon(Icons.category), title: Text('Categories')),
          ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
        ],
      ),
    );
  }
}

// Category Chip
class CategoryChip extends StatelessWidget {
  final String label;

  CategoryChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.green[100],
      ),
    );
  }
}

// Offer Card
class OfferCard extends StatelessWidget {
  final String title;
  final IconData icon;

  OfferCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.green),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text('Special deals available!',
              style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

// Product Section
class ProductSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;

  ProductSection({required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Text(title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          height: 260,
          padding: EdgeInsets.only(left: 16),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return ProductCard(
                imageUrl: product['imageUrl'],
                productName: product['name'],
                price: product['price'],
              );
            },
          ),
        ),
      ],
    );
  }
}

// Product Card (your yesterday's modern style)
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;

  const ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(imageUrl,
                  fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(productName,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('\$${price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green[700])),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
