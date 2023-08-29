
import 'package:applist3/data/models/data_models.dart';
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';




 List<Map<String, dynamic>> daftarProducts = [
  {
    'id': 1,
    'namaProduk': 'Apple',
    'harga': 55000,
    'stock': 33,
    'gambar':
        'https://5.imimg.com/data5/AK/RA/MY-68428614/apple-1000x1000.jpg',
  },
  {
    'id': 2,
    'namaProduk': 'Orange',
    'harga': 35000,
    'stock': 20,
    'gambar':
        'https://i0.wp.com/www.astronauts.id/blog/wp-content/uploads/2022/12/Agar-Tidak-Salah-Ini-Cara-Memilih-Jeruk-yang-Manis.jpg?w=1280&ssl=1',
  },
  {
    'id': 3,
    'namaProduk': 'Banana',
    'harga': 25000,
    'stock': 50,
    'gambar':
        'https://www.astronauts.id/blog/wp-content/uploads/2023/02/Kenali-Ciri-Buah-Pisang-Matang.jpg',
  },
];

class ProductNotifier extends ChangeNotifier {
  List<Product> products = []; // List of Product objects
  List<Product> searchResults = [];
  bool isLoading = false;

  void create(Product data) {
    try {
      products.add(data);
      notifyListeners();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void search(String query) {
    searchResults = products.where((product) {
      return (product.namaProduk ?? '').toLowerCase().contains(query.toLowerCase()) ||
          product.id.toString() == query;
    }).toList();
    notifyListeners();
  }

  Future<void> getProduct() async {
    try {
      isLoading = true;
      notifyListeners();

     await Future.delayed(1.s);


      // Convert daftarProducts to Product objects using fromJson()
      products = daftarProducts.map((e) => Product.fromJson(e)).toList();

      isLoading = false;
      notifyListeners();
    } catch (e,s) {
      Errors.check(e,s);
      // Handle errors
    }
  }

  void update(int id, Product value) {
    try {
      final index = products.indexWhere((e) => e.id == id);
      if (index > -1) {
        products[index] = value;
        notifyListeners();
      }
    } catch (e,s) {
      Errors.check(e,s);
      // Handle errors
    }
  }

  void deleteProduct(int productId) {
    products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}



