// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:ppksaleapp/colors/colors.dart';
// import 'package:ppksaleapp/screens/homescreen.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // 3 Second kazhiyumpol Home-ilekk pokum
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: PrimeColor, // Nammude main blue color
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black,
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                   )
//                 ],
//               ),
//               child: Icon(Icons.inventory, size: 80, color: PrimeColor),
//             ),
//             const SizedBox(height: 20),
//             // App Name
//             const Text(
//               "PPK SALES",
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 letterSpacing: 2,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Cement Management System",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white70,
//               ),
//             ),
//             const SizedBox(height: 50),
//             // Loading indicator
//             const CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }