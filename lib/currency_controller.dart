import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_node_task/Api%20Constant/api_constant.dart';

class CurrencyController extends GetxController {
  var sourceCurrency = 'USD'.obs;
  var targetCurrency = 'EUR'.obs;
  var inputAmount = ''.obs;
  var conversionResult = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserPreferences();
  }

  Future<void> loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    sourceCurrency.value = prefs.getString('fromCurrency') ?? 'USD';
    targetCurrency.value = prefs.getString('toCurrency') ?? 'EUR';
  }

  Future<void> saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fromCurrency', sourceCurrency.value);
    await prefs.setString('toCurrency', targetCurrency.value);
  }

  Future<double> fetchConversionRate(
      String fromCurrency, String toCurrency) async {
    final url = '${ApiConstant.url}$fromCurrency';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log("Response $data['rates'][toCurrency] }");
      return data['rates'][toCurrency] ?? 0.0;
    } else {
      throw Exception('Failed to fetch conversion rate');
    }
  }

  Future<void> convertCurrency() async {
    if (inputAmount.value.isEmpty) {
      Get.snackbar('Error', 'Please enter a valid amount',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      final rate =
          await fetchConversionRate(sourceCurrency.value, targetCurrency.value);
      final amount = double.tryParse(inputAmount.value) ?? 0.0;
      conversionResult.value = amount * rate;
      saveUserPreferences();
    } catch (e) {
      Get.snackbar('Error', 'Failed to convert currency',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateSourceCurrency(String currency) {
    sourceCurrency.value = currency;
  }

  void updateTargetCurrency(String currency) {
    targetCurrency.value = currency;
  }

  void updateInputAmount(String amount) {
    inputAmount.value = amount;
  }
}
