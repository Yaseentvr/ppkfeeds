import 'package:flutter/material.dart';
import 'package:ppksaleapp/colors/colors.dart';
import 'package:ppksaleapp/provider/stock_provider.dart';
import 'package:ppksaleapp/screens/add_stock_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stockData = Provider.of<StockProvider>(context);
    final brandNames = stockData.stockData.keys.toList();
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(backgroundColor: PrimeColor, title: const Text('PPK FEEDS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), centerTitle: true),
      body: Column(
        children: [
          Container(padding: const EdgeInsets.all(20), width: double.infinity, child: const Text('Inventory Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Expanded(
            child: brandNames.isEmpty 
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.inventory_2_outlined, size: 70, color: Colors.grey[400]), const Text("No Stocks Added")]))
              : ListView.builder(
                  itemCount: brandNames.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    String brand = brandNames[index];
                    int count = stockData.stockData[brand] ?? 0;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onLongPress: () => _showDeleteDialog(context, brand, stockData),
                        title: Text(brand, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text("Hold to delete", style: TextStyle(fontSize: 10, color: Colors.grey)),
                        trailing: Text("$count Bags", style: TextStyle(color: PrimeColor, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: PrimeColor, minimumSize: const Size(double.infinity, 60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddStock())),
              child: const Text("ADD NEW STOCK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String brand, StockProvider provider) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Delete Brand?"),
      content: Text("Remove '$brand' from list?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        TextButton(onPressed: () { provider.deleteBrand(brand); Navigator.pop(context); }, child: const Text("DELETE", style: TextStyle(color: Colors.red))),
      ],
    ));
  }
}