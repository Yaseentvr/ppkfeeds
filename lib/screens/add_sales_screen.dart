import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ppksaleapp/colors/colors.dart';
import 'package:ppksaleapp/provider/stock_provider.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});
  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();
  String? selectedBrand;

  void _handleSave() {
    if (selectedBrand != null && qtyController.text.isNotEmpty && priceController.text.isNotEmpty) {
      Provider.of<StockProvider>(context, listen: false).sellCement(
        selectedBrand!,
        int.parse(qtyController.text),
        double.parse(priceController.text),
        nameController.text.isEmpty ? "No Name" : nameController.text,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sale Recorded!"), backgroundColor: Colors.green));
      
      setState(() {
        nameController.clear();
        qtyController.clear();
        priceController.clear();
        selectedBrand = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final brands = Provider.of<StockProvider>(context).brands;
    return Scaffold(
      appBar: AppBar(title: const Text("വിൽപന രേഖപ്പെടുത്തുക", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: PrimeColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: "കസ്റ്റമർ പേര്", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
          const SizedBox(height: 15),
          DropdownButtonFormField<String>(
            value: selectedBrand,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Select Brand", prefixIcon: Icon(Icons.category)),
            items: brands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
            onChanged: (v) => setState(() => selectedBrand = v),
          ),
          const SizedBox(height: 15),
          Row(children: [
            Expanded(child: TextField(controller: qtyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Bags", border: OutlineInputBorder(), prefixIcon: Icon(Icons.numbers)))),
            const SizedBox(width: 10),
            Expanded(child: TextField(controller: priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Rate (₹)", border: OutlineInputBorder(), prefixIcon: Icon(Icons.currency_rupee)))),
          ]),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: PrimeColor, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: _handleSave,
            child: const Text("SAVE SALE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}