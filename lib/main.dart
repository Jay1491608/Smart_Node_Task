import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smart_node_task/currency_converter_screen.dart';

void main() {
  runApp(CurrencyConverter());
}

class CurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: false),
      home: CurrencyConverterScreen(),
    );
  }
}
