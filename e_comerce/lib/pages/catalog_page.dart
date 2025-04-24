import 'package:e_comerce/pages/product_detail_page.dart';
import 'package:flutter/material.dart';

import '../models/sample_product.dart';
import '../widgets/cart_icon_with_badge.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CartIconWithBadge(),
        ],
        title: Text('Product Catalog'),
      ),
      body: ListView.builder(
        itemCount: sampleProducts.length,
        itemBuilder: (ctx, i) => Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(sampleProducts[i].imageUrl),
            title: Text(sampleProducts[i].title),
            subtitle: Text('\$${sampleProducts[i].price.toStringAsFixed(2)}'),
            trailing: Icon(Icons.add_shopping_cart),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: sampleProducts[i]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
