import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ppksaleapp/colors/colors.dart';
import 'package:ppksaleapp/provider/stock_provider.dart';

class AddStock extends StatefulWidget {
  const AddStock({super.key});
  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  final qtyController = TextEditingController();
  final priceController = TextEditingController();
  final newBrandController = TextEditingController();
  String? selectedBrand;

  void _addNewBrandDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("New Cement Company"),
      content: TextField(
        controller: newBrandController, 
        decoration: const InputDecoration(hintText: "Enter Name"),
        textCapitalization: TextCapitalization.words,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: PrimeColor),
          onPressed: () {
            if (newBrandController.text.isNotEmpty) {
              Provider.of<StockProvider>(context, listen: false).addNewBrand(newBrandController.text);
              setState(() { selectedBrand = newBrandController.text; });
              newBrandController.clear();
              Navigator.pop(context);
            }
          }, 
          child: const Text("Add", style: TextStyle(color: Colors.white))
        )
      ],
    ));
  }

  void _handleSaveStock() {
    final stockProvider = Provider.of<StockProvider>(context, listen: false);
    
    if (selectedBrand != null && qtyController.text.isNotEmpty) {
      try {
        // Data Save cheyyunnu
        stockProvider.addStock(
          selectedBrand!, 
          int.parse(qtyController.text),
          // totalPrice: priceController.text.isNotEmpty ? double.parse(priceController.text) : 0, 
          // (Provider-il nammal ippo addStock-il price handle cheyyunnilla enkil ithu ignore cheyyam)
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$selectedBrand Stock Added!"), backgroundColor: Colors.green)
        );

        // FIELDS CLEAR CHEYYUNNU (Nee chodichathu pole)
        setState(() {
          qtyController.clear();
          priceController.clear();
          selectedBrand = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Correct quantity type cheyyu"), backgroundColor: Colors.orange)
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select Brand & Quantity"), backgroundColor: Colors.redAccent)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("സ്റ്റോക്ക് ചേർക്കുക", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
        backgroundColor: PrimeColor, 
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("ബ്രാൻഡ് തിരഞ്ഞെടുക്കുക", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedBrand, 
                  hint: const Text("Select Brand"),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  items: stockProvider.brands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                  onChanged: (v) => setState(() => selectedBrand = v),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(onPressed: _addNewBrandDialog, icon: Icon(Icons.add_circle, size: 45, color: PrimeColor))
            ]),
            const SizedBox(height: 25),
            const Text("സ്റ്റോക്ക് വിവരങ്ങൾ", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildTextField(qtyController, "Quantity (Bags)", Icons.inventory_2),
            const SizedBox(height: 15),
            _buildTextField(priceController, "Total Purchase Price (₹)", Icons.currency_rupee),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimeColor, 
                minimumSize: const Size(double.infinity, 60), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              onPressed: _handleSaveStock,
              child: const Text("SAVE STOCK", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller, 
      keyboardType: TextInputType.number, 
      decoration: InputDecoration(
        labelText: label, 
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), 
        prefixIcon: Icon(icon, color: PrimeColor)
      )
    );
  }
}