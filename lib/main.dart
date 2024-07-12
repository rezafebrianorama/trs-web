import 'package:flutter/material.dart';
import 'package:flutter_web_trs/screens/addProduk.dart';
import 'package:flutter_web_trs/screens/dashboard.dart';
import 'package:flutter_web_trs/screens/login.dart';
import 'package:flutter_web_trs/screens/produks.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(fontFamily: 'Poppins'),
        routes: {
          '/': (context) {
            return const LoginScreen();
          },
          '/dashbord': (context) {
            return const DashboardScreen();
          },
          '/produk': (context) {
            return const ProdukScreen();
          },
          '/add-produk': (context) {
            return const AddProdukScreen();
          },
        });
  }
}
