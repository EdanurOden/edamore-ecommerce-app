import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final List<Product> _favorites = [];

  List<CartItem> get cartItems => _cartItems;
  List<Product> get favorites => _favorites;

  // Toplam ürün adedi (quantity'lerin toplamı)
  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  int get favoriteCount => _favorites.length;

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Sepete ekle
  void addToCart(Product product) {
    // Ürün zaten sepette mi kontrol et
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Varsa miktarı artır
      _cartItems[existingIndex].quantity++;
    } else {
      // Yoksa yeni ekle
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Sepetten çıkar
  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Miktar artır
  void increaseQuantity(String productId) {
    final item = _cartItems.firstWhere((item) => item.product.id == productId);
    item.quantity++;
    notifyListeners();
  }

  // Miktar azalt
  void decreaseQuantity(String productId) {
    final item = _cartItems.firstWhere((item) => item.product.id == productId);
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  // Sepeti temizle
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Favorilere ekle/çıkar
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }

  // Sepette mi kontrol
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }
}
