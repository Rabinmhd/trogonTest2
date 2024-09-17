// pages/home_page.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trogon_machine_test_2/controller/controller_get.dart';
import 'package:trogon_machine_test_2/models/model.dart';
import 'package:trogon_machine_test_2/pages/detailsPage.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Home Page'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.errorMessage.isNotEmpty) {
          return Center(child: Text(productController.errorMessage.value));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: [
                      Image.network(
                          "https://www.cnet.com/a/img/resize/7de0b5f97707eb6d4761f53e08ee94cc677a8226/hub/2024/09/09/583dd271-f9e1-4ae2-ab6e-e820b197ea32/iphone-16-thumb.png?auto=webp&width=1200"),
                      Image.network(
                          "https://images.indianexpress.com/2023/10/iPad-Air-Express-Photo.jpg?w=414"),
                      Image.network(
                          "https://5.imimg.com/data5/SELLER/Default/2021/10/IF/KB/XR/139308266/lg-inverter-direct-cool-single-door-refrigerator-with-long-lasting-compressor.JPG")
                    ],
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )),
                _buildCategorySection(
                    'New Arrivals', productController.productList),
                _buildCategorySection('Trending Products',
                    productController.productList.reversed.toList()),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildCategorySection(String title, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, products[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext ctx,
    Product product,
    BuildContext context,
  ) {
    Map<String, String> devices = {
      "Laptop": "assets/laptop.jpeg",
      "laptop2": "assets/laptop2.jpeg",
      "laptop3": "assets/laptop3.jpeg",
      "laptop4": "assets/laptop4.jpeg",
      "Professional DSLR Camera": "assets/nikon.jpeg",
      "Smartphone": "assets/phone.jpeg",
      "phone2": "assets/phone2.jpeg",
      "Gaming Console": "assets/ps5.jpeg",
      "Energy-Efficient Refrigerator": "assets/fridge.jpeg",
      "Smartwatch": "assets/smartwatch.jpg",
      "Tablet": "assets/tablet.jpeg",
      "Wireless Headphones": "assets/tws.webp",
      "Smart TV": "assets/tv.webp"
    };

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: product,
                image: devices[product.name]!,
              ),
            ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    devices[product.name] ?? "Laptop",
                    fit: BoxFit.contain,
                  )),
              const SizedBox(height: 8),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Brand: ${product.brand}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text('Price: \$${product.price.toStringAsFixed(2)}'),
              Text(
                'Discount: \$${(product.price * 0.9).toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.red),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(product.rating.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
