import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/address.dart';
import '../models/order.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _hasShownLoginPrompt = false;

  // Session bazlı veriler
  final List<Address> _addresses = [];
  final List<String> _messages = [];
  final List<Order> _orders = [];

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasShownLoginPrompt => _hasShownLoginPrompt;
  List<Address> get addresses => _addresses;
  List<String> get messages => _messages;
  List<Order> get orders => _orders;

  // Otomatik giriş kontrolü
  void checkAutoLogin() {
    _isLoggedIn = false;
    notifyListeners();
  }

  // Login prompt gösterildi işaretle
  void markLoginPromptShown() {
    _hasShownLoginPrompt = true;
    notifyListeners();
  }

  // Login
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email == 'test@test.com' && password == '123456') {
      _currentUser = mockUser;
      _isLoggedIn = true;
      _hasShownLoginPrompt = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Register
  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    _currentUser = User(
      id: DateTime.now().toString(),
      name: name,
      email: email,
      phone: '',
      address: '',
    );
    _isLoggedIn = true;
    _hasShownLoginPrompt = false;
    notifyListeners();
    return true;
  }

  // Profil Güncelle
  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? tcNo,
    String? postalCode,
    String? city,
    String? district,
  }) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        email: email,
        phone: phone,
        address: address,
        tcNo: tcNo,
        postalCode: postalCode,
        city: city,
        district: district,
      );
      notifyListeners();
    }
  }

  // Adres Ekle
  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  // Adres Sil
  void removeAddress(String addressId) {
    _addresses.removeWhere((addr) => addr.id == addressId);
    notifyListeners();
  }

  // Mesaj Ekle
  void addMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }

  // Sipariş Ekle
  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  // Logout - Tüm session verilerini temizle
  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    _hasShownLoginPrompt = false;
    _addresses.clear();
    _messages.clear();
    _orders.clear();
    notifyListeners();
  }

  // Login gerekliliğini kontrol et
  Future<bool> requireLogin(BuildContext context) async {
    if (_isLoggedIn) return true;
    final result = await Navigator.pushNamed(context, '/login');
    return result == true;
  }
}
