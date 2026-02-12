import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleEntry {
  final String brand;
  final String customerName;
  final int quantity;
  final double amount;
  final DateTime date;

  SaleEntry({required this.brand, required this.customerName, required this.quantity, required this.amount, required this.date});

  Map<String, dynamic> toMap() => {
    'brand': brand, 'customerName': customerName, 'quantity': quantity, 'amount': amount, 'date': date.toIso8601String(),
  };

  factory SaleEntry.fromMap(Map<String, dynamic> map) => SaleEntry(
    brand: map['brand'], 
    customerName: map['customerName'] ?? "No Name", 
    quantity: map['quantity'], 
    amount: map['amount'], 
    date: DateTime.parse(map['date']),
  );
}

class StockProvider extends ChangeNotifier {
  Map<String, int> stockData = {}; 
  List<String> brands = []; 
  List<SaleEntry> _salesHistory = [];

  StockProvider() { loadFromPhone(); }

  List<SaleEntry> get salesHistory => _salesHistory;

  // Sale rēkhappeduthunnu
  void sellCement(String brand, int quantity, double price, String customer) {
    if (stockData.containsKey(brand)) {
      stockData[brand] = (stockData[brand] ?? 0) - quantity;
      _salesHistory.add(SaleEntry(
        brand: brand, 
        customerName: customer, 
        quantity: quantity, 
        amount: quantity * price, 
        date: DateTime.now()
      ));
      saveToPhone();
      notifyListeners();
    }
  }

  // Stock add cheyyunnu
  void addStock(String brand, int quantity) {
    stockData[brand] = (stockData[brand] ?? 0) + quantity;
    if (!brands.contains(brand)) brands.add(brand);
    saveToPhone();
    notifyListeners();
  }

  void addNewBrand(String name) {
    if (!brands.contains(name)) {
      brands.add(name);
      stockData[name] = 0;
      saveToPhone();
      notifyListeners();
    }
  }

  void deleteBrand(String brand) {
    stockData.remove(brand);
    brands.remove(brand);
    saveToPhone();
    notifyListeners();
  }

  // Kanakkukaḷ (Today & Monthly)
  int get dailyTotal => _salesHistory.where((s) => s.date.day == DateTime.now().day && s.date.month == DateTime.now().month).fold(0, (sum, item) => sum + item.quantity);
  double get dailyCash => _salesHistory.where((s) => s.date.day == DateTime.now().day && s.date.month == DateTime.now().month).fold(0.0, (sum, item) => sum + item.amount);
  double get monthlyCash => _salesHistory.where((s) => s.date.month == DateTime.now().month && s.date.year == DateTime.now().year).fold(0.0, (sum, item) => sum + item.amount);

  // PHONE-ILEKK SAVE CHEYYUNNA LOGIC
  Future<void> saveToPhone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('stocks', jsonEncode(stockData));
    await prefs.setStringList('brands', brands);
    await prefs.setString('history', jsonEncode(_salesHistory.map((e) => e.toMap()).toList()));
  }

  // PHONE-IL NINNU THIRICHU EDUKKUNNA LOGIC
  Future<void> loadFromPhone() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('stocks')) stockData = Map<String, int>.from(jsonDecode(prefs.getString('stocks')!));
    if (prefs.containsKey('brands')) brands = prefs.getStringList('brands')!;
    if (prefs.containsKey('history')) {
      _salesHistory = (jsonDecode(prefs.getString('history')!) as List).map((e) => SaleEntry.fromMap(e)).toList();
    }
    notifyListeners();
  }
}