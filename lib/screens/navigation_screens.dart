import 'package:flutter/material.dart';
import 'package:ppksaleapp/colors/colors.dart';
import 'package:ppksaleapp/screens/add_sales_screen.dart';
import 'package:ppksaleapp/screens/homescreen.dart';
import 'package:ppksaleapp/screens/sales_screen.dart';

// 1. Ithaanu App thurakkumbol varunne Main Page
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Vellippakk vendiya Pages
  final List<Widget> _pages = [
    const HomeScreen(),        // Screen 1: Dashboard
    const AddSaleScreen(),     // Screen 2: Vilpana (Nee undakkan ullathu)
    const SaleScreen(),     // Screen 3: Kanakku (Nee undakkan ullathu)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body-il index anusarichu screen marum
      body: _pages[_selectedIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: PrimeColor, // Ninte custom color
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Ellam eppozhum kanikkaan
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'ഹോം'),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), label: 'വിൽപന'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'കണക്ക്'),
        ],
      ),
    );
  }
}