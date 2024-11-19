import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:smart_node_task/currency_controller.dart';

class CurrencyConverterScreen extends StatelessWidget {
  final controller = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => ListTile(
                  title: const Text('Source Currency'),
                  subtitle: Text(controller.sourceCurrency.value),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      onSelect: (currency) {
                        controller.updateSourceCurrency(currency.code);
                      },
                    );
                  },
                )),
            const SizedBox(height: 16),
            Obx(() => ListTile(
                  title: const Text('Target Currency'),
                  subtitle: Text(controller.targetCurrency.value),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      onSelect: (currency) {
                        controller.updateTargetCurrency(currency.code);
                      },
                    );
                  },
                )),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                onChanged: (value) => controller.updateInputAmount(value),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.convertCurrency();
              },
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
                  'Converted Amount: ${controller.conversionResult.value.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
