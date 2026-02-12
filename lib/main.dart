import 'package:flutter/material.dart';
import 'package:ppksaleapp/screens/navigation_screens.dart';
import 'package:ppksaleapp/provider/stock_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context)=> StockProvider(),child: const MyApp(),));
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigationScreen(),
    );
  }
}
