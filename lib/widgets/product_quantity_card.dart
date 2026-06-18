import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/cart_state.dart';
import '../state/cart_state.dart';

// The units a product can be ordered in.
enum ProductUnit { grams, kilograms, pieces, packets }

extension ProductUnitLabel on ProductUnit {
  String get label {
    switch (this) {
      case ProductUnit.grams:
        return 'g';
      case ProductUnit.kilograms:
        return 'kg';
      case ProductUnit.pieces:
        return 'pcs';
      case ProductUnit.packets:
        return 'packets';
    }
  }
}

class ProductQuantityCard extends StatefulWidget {
  final String productName;
  final int freshnessPercent;
  final List<ProductUnit> availableUnits;

  const ProductQuantityCard({
    super.key,
    required this.productName,
    required this.freshnessPercent,
    required this.availableUnits,
  });

  @override
  State<ProductQuantityCard> createState() => _ProductQuantityCardState();
}

class _ProductQuantityCardState extends State<ProductQuantityCard> {
  final TextEditingController _qtyController = TextEditingController();
  late ProductUnit _selectedUnit;

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.availableUnits.first;
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glassPanelFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name
          Text(
            widget.productName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textHigh,
            ),
          ),
          const SizedBox(height: 6),

          // Freshness percentage
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.emerald,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
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
          const SizedBox(height: 12),

          // Quantity input row: text box + unit dropdown
          Row(
            children: [
              // Free text box for any amount
              Expanded(
                child: TextField(
                  controller: _qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Qty',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.glassBorder),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Unit dropdown (g, kg, pcs, packets — depends on product)
              DropdownButton<ProductUnit>(
                value: _selectedUnit,
                underline: const SizedBox(),
                items: widget.availableUnits.map((unit) {
                  return DropdownMenuItem(value: unit, child: Text(unit.label));
                }).toList(),
                onChanged: (newUnit) {
                  setState(() {
                    _selectedUnit = newUnit!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Add to cart button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final qty = _qtyController.text;
                if (qty.isEmpty) return;
                cartState.addItem(widget.productName, qty, _selectedUnit);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ' + qty + ' ' + _selectedUnit.label + ' ' + widget.productName + ' to cart'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: AppColors.emerald,
                  ),
                );
                _qtyController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.emeraldBright,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Add to cart', style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
