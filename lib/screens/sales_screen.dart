import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ppksaleapp/colors/colors.dart';
import 'package:ppksaleapp/provider/stock_provider.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<StockProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text("Sales Report", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: PrimeColor, centerTitle: true),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Row(children: [
              _card("Today Bags", "${data.dailyTotal}", Colors.orange),
              const SizedBox(width: 10),
              _card("Today Cash", "₹${data.dailyCash.toStringAsFixed(0)}", Colors.blue),
            ]),
            const SizedBox(height: 10),
            _card("Monthly Income", "₹${data.monthlyCash.toStringAsFixed(0)}", Colors.green, wide: true),
          ]),
        ),
        const Divider(),
        Expanded(
          child: data.salesHistory.isEmpty 
          ? const Center(child: Text("No Sales Recorded Yet!"))
          : ListView.builder(
              itemCount: data.salesHistory.length,
              itemBuilder: (context, index) {
                // Latest sales aadyam kaanikkan
                final s = data.salesHistory.reversed.toList()[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: PrimeColor.withOpacity(0.1), child: const Icon(Icons.person)),
                    title: Text(s.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${s.brand} - ${s.quantity} Bags"),
                    trailing: Text("₹${s.amount.toStringAsFixed(0)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
        )
      ]),
    );
  }

  Widget _card(String t, String v, Color c, {bool wide = false}) {
    return Expanded(
      flex: wide ? 0 : 1, 
      child: Container(
        width: wide ? double.infinity : null, 
        padding: const EdgeInsets.all(15), 
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: c.withOpacity(0.5)), borderRadius: BorderRadius.circular(15)), 
        child: Column(children: [
          Text(t, style: TextStyle(color: c, fontWeight: FontWeight.bold)), 
          Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ])
      )
    );
  }
}