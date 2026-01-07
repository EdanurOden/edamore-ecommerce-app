import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/product_provider.dart';
import '../../../data/models/filter_options.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FilterOptions _tempFilters;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    _tempFilters = provider.filterOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('KATEGORİ'),
                  SizedBox(height: 8),
                  _buildCategoryChips(),
                  SizedBox(height: 24),
                  _buildSectionTitle('FİYAT ARALIĞI'),
                  SizedBox(height: 8),
                  _buildPriceSlider(),
                  SizedBox(height: 24),
                  _buildSectionTitle('SIRALAMA'),
                  SizedBox(height: 8),
                  _buildSortOptions(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'FİLTRELE',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppCategories.all.map((category) {
        final isSelected = _tempFilters.selectedCategories.contains(category);
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              final categories = List<String>.from(
                _tempFilters.selectedCategories,
              );
              if (selected) {
                categories.add(category);
              } else {
                categories.remove(category);
              }
              _tempFilters = _tempFilters.copyWith(
                selectedCategories: categories,
              );
            });
          },
          selectedColor: Color(0xFFD4A5B0),
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      children: [
        RangeSlider(
          values: RangeValues(_tempFilters.minPrice, _tempFilters.maxPrice),
          min: 0,
          max: 1000,
          divisions: 20,
          activeColor: Color(0xFF7A9EAF),
          labels: RangeLabels(
            '${_tempFilters.minPrice.toInt()}₺',
            '${_tempFilters.maxPrice.toInt()}₺',
          ),
          onChanged: (values) {
            setState(() {
              _tempFilters = _tempFilters.copyWith(
                minPrice: values.start,
                maxPrice: values.end,
              );
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_tempFilters.minPrice.toInt()}₺'),
            Text('${_tempFilters.maxPrice.toInt()}₺'),
          ],
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    return Column(
      children: SortOption.values.map((option) {
        return RadioListTile<SortOption>(
          title: Text(option.label),
          value: option,
          groupValue: _tempFilters.sortBy,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _tempFilters = _tempFilters.copyWith(sortBy: value);
              });
            }
          },
          activeColor: Color(0xFF7A9EAF),
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final provider = Provider.of<ProductProvider>(
                  context,
                  listen: false,
                );
                provider.clearFilters();
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('TEMİZLE'),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                final provider = Provider.of<ProductProvider>(
                  context,
                  listen: false,
                );
                provider.updateFilters(_tempFilters);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('UYGULA'),
            ),
          ),
        ],
      ),
    );
  }
}
