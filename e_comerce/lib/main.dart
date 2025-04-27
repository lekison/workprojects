import 'package:e_comerce/pages/cart_page.dart';
import 'package:e_comerce/pages/checkout_page.dart';
import 'package:e_comerce/pages/payment_success_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/catalog_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/catalog': (context) => HomePage(),
        '/checkout': (context) => CheckoutPage(),
        '/payment-success': (context) => PaymentSuccessPage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}
