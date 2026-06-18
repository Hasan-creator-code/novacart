import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/cart_state.dart';

enum ProductUnit { grams, kilograms, pieces, packets, litres, millilitres }

extension ProductUnitLabel on ProductUnit {
  String get label {
    switch (this) {
      case ProductUnit.grams: return 'g';
      case ProductUnit.kilograms: return 'kg';
      case ProductUnit.pieces: return 'pcs';
      case ProductUnit.packets: return 'pkts';
      case ProductUnit.litres: return 'L';
      case ProductUnit.millilitres: return 'ml';
    }
  }
}

class ProductQuantityCard extends StatefulWidget {
  final String productName;
  final int freshnessPercent;

  const ProductQuantityCard({
    super.key,
    required this.productName,
    required this.freshnessPercent,
  });

  @override
  State<ProductQuantityCard> createState() => _ProductQuantityCardState();
}

class _ProductQuantityCardState extends State<ProductQuantityCard> {
  final TextEditingController _qtyController = TextEditingController();
  ProductUnit _selectedUnit = ProductUnit.grams;

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8F0EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product name
          Text(
            widget.productName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textHigh,
            ),
          ),
          const SizedBox(height: 4),

          // Freshness
          Row(
            children: [
              Container(
                width: 6, height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.emerald,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.freshnessPercent}% fresh',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.emerald,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Quantity input
          TextField(
            controller: _qtyController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14, color: AppColors.textHigh),
            decoration: InputDecoration(
              hintText: 'Enter qty',
              hintStyle: const TextStyle(color: AppColors.textLow, fontSize: 13),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              filled: true,
              fillColor: const Color(0xFFF4F8F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Unit pill buttons — 3 per row
          Column(
            children: [
              // Row 1: g, kg, pcs
              Row(
                children: [
                  ProductUnit.grams,
                  ProductUnit.kilograms,
                  ProductUnit.pieces,
                ].map((unit) => _unitPill(unit)).toList(),
              ),
              const SizedBox(height: 4),
              // Row 2: pkts, L, ml
              Row(
                children: [
                  ProductUnit.packets,
                  ProductUnit.litres,
                  ProductUnit.millilitres,
                ].map((unit) => _unitPill(unit)).toList(),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Add to cart button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () async {
                final qty = _qtyController.text;
                if (qty.isEmpty) return;
                await cartState.addItem(widget.productName, qty, _selectedUnit);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added $qty ${_selectedUnit.label} ${widget.productName} to cart'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: AppColors.emerald,
                  ),
                );
                _qtyController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.emerald,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add to cart',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _unitPill(ProductUnit unit) {
    final isSelected = _selectedUnit == unit;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedUnit = unit),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.emerald : const Color(0xFFF4F8F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            unit.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textMedium,
            ),
          ),
        ),
      ),
    );
  }
}
