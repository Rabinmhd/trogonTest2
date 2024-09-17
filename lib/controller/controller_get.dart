// controllers/product_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trogon_machine_test_2/models/model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    const apiUrl =
        'https://fake-store-api.mock.beeceptor.com/api/products'; // Replace with your API endpoint

    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body) as List;
        productList.value =
            data.map((product) => Product.fromJson(product)).toList();
      } else {
        errorMessage('Failed to load products');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
