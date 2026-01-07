import 'package:flutter/material.dart';
import '../models/address.dart';

class AddressProvider with ChangeNotifier {
  final List<Address> _addresses = [];

  // Listeyi dışarı veriyoruz (okuma)
  List<Address> get addresses => _addresses;

  // Adres ekleme
  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  // Adres silme
  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  // LOGOUT için
  void clear() {
    _addresses.clear();
    notifyListeners();
  }
}
