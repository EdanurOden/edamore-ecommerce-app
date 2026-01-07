import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/filter_options.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _allProducts = mockProducts;
  List<Product> _filteredProducts = mockProducts;

  String _searchQuery = '';
  FilterOptions _filterOptions = FilterOptions();

  List<Product> get products => _filteredProducts;
  String get searchQuery => _searchQuery;
  FilterOptions get filterOptions => _filterOptions;
  int get productCount => _filteredProducts.length;

  // Arama
  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  // Filtre güncelle
  void updateFilters(FilterOptions options) {
    _filterOptions = options;
    _applyFilters();
  }

  // Filtreleri temizle
  void clearFilters() {
    _searchQuery = '';
    _filterOptions = FilterOptions();
    _filteredProducts = _allProducts;
    notifyListeners();
  }

  // Kategori
  void toggleCategory(String category) {
    final categories = List<String>.from(_filterOptions.selectedCategories);

    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }

    _filterOptions = _filterOptions.copyWith(selectedCategories: categories);
    _applyFilters();
  }

  // Tek kategori seç
  void selectSingleCategory(String category) {
    _filterOptions = _filterOptions.copyWith(selectedCategories: [category]);
    _applyFilters();
  }

  // Filtre uygulama
  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      bool matchesSearch =
          _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery) ||
          product.category.toLowerCase().contains(_searchQuery);

      bool matchesCategory =
          _filterOptions.selectedCategories.isEmpty ||
          _filterOptions.selectedCategories.contains(product.category);

      bool matchesPrice =
          product.price >= _filterOptions.minPrice &&
          product.price <= _filterOptions.maxPrice;

      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();

    // Sıralama
    switch (_filterOptions.sortBy) {
      case SortOption.priceAsc:
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceDesc:
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      case SortOption.popular:
        _filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
      case SortOption.newest:
        break;
    }

    notifyListeners();
  }

  // ID'ye göre ürün bul
  Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
