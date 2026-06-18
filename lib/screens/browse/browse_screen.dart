import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/product_quantity_card.dart';

class Product {
  final String name;
  final String category;
  final int freshnessPercent;

  const Product({
    required this.name,
    required this.category,
    required this.freshnessPercent,
  });
}

const List<Product> _sampleProducts = [
  Product(name: 'Rice', category: 'Staples', freshnessPercent: 92),
  Product(name: 'Wheat Flour', category: 'Staples', freshnessPercent: 88),
  Product(name: 'Sugar', category: 'Staples', freshnessPercent: 95),
  Product(name: 'Eggs', category: 'Dairy & Eggs', freshnessPercent: 85),
  Product(name: 'Milk', category: 'Dairy & Eggs', freshnessPercent: 78),
  Product(name: 'Butter', category: 'Dairy & Eggs', freshnessPercent: 82),
  Product(name: 'Bread', category: 'Bakery', freshnessPercent: 70),
  Product(name: 'Bun', category: 'Bakery', freshnessPercent: 65),
  Product(name: 'Tomatoes', category: 'Vegetables', freshnessPercent: 80),
  Product(name: 'Onions', category: 'Vegetables', freshnessPercent: 90),
  Product(name: 'Potatoes', category: 'Vegetables', freshnessPercent: 88),
  Product(name: 'Bananas', category: 'Fruits', freshnessPercent: 75),
  Product(name: 'Apples', category: 'Fruits', freshnessPercent: 83),
];

const List<String> _categories = [
  'All', 'Staples', 'Dairy & Eggs', 'Bakery', 'Vegetables', 'Fruits',
];

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    return _sampleProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textLow),
                  filled: true,
                  fillColor: AppColors.glassPanelFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: AppColors.glassBorder),
                  ),
                ),
              ),
            ),

            // Category chips
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (_) =>
                          setState(() => _selectedCategory = cat),
                      selectedColor: AppColors.emerald,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textMedium,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Product grid
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(color: AppColors.textMedium),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),

                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ProductQuantityCard(
                          key: ValueKey(product.name),
                          productName: product.name,
                          freshnessPercent: product.freshnessPercent,
                        ));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
