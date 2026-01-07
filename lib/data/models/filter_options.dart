class FilterOptions {
  final List<String> selectedCategories;
  final double minPrice;
  final double maxPrice;
  final SortOption sortBy;

  FilterOptions({
    this.selectedCategories = const [],
    this.minPrice = 0,
    this.maxPrice = 1000,
    this.sortBy = SortOption.newest,
  });

  FilterOptions copyWith({
    List<String>? selectedCategories,
    double? minPrice,
    double? maxPrice,
    SortOption? sortBy,
  }) {
    return FilterOptions(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  bool get hasActiveFilters {
    return selectedCategories.isNotEmpty ||
        minPrice > 0 ||
        maxPrice < 1000 ||
        sortBy != SortOption.newest;
  }
}

enum SortOption {
  newest('En Yeni'),
  priceAsc('En Düşük Fiyat'),
  priceDesc('En Yüksek Fiyat'),
  popular('En Popüler');

  final String label;
  const SortOption(this.label);
}

class AppCategories {
  static const List<String> all = [
    'Kolye',
    'Bileklik',
    'Çanta',
    'Lego',
    'Figürler',
    'charm',
  ];
}
