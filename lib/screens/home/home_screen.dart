import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/product_quantity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMedium,
                          ),
                          children: [
                            const TextSpan(text: 'Good evening, '),
                            TextSpan(
                              text: 'Aisha',
                              style: TextStyle(
                                color: AppColors.textHigh,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your pantry is 91% stocked',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textLow,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(radius: 20, backgroundColor: AppColors.emerald),
                ],
              ),
              const SizedBox(height: 24),

              // Auto-Pantry card (the signature feature!)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.emerald.withOpacity(0.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AUTO-PANTRY',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.emerald,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Milk & eggs run out in 3 days',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textHigh,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Based on your usage, we\'ve built a cart so you never run dry.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldBright,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Review →'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Live freshness & quantity row
              const Text(
                'Live freshness near you',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textHigh,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductQuantityCard(
                      productName: 'Rice',
                      freshnessPercent: 92,
                      availableUnits: [
                        ProductUnit.grams,
                        ProductUnit.kilograms,
                      ],
                    ),
                    const SizedBox(width: 12),
                    ProductQuantityCard(
                      productName: 'Eggs',
                      freshnessPercent: 88,
                      availableUnits: [ProductUnit.pieces],
                    ),
                    const SizedBox(width: 12),
                    ProductQuantityCard(
                      productName: 'Bread',
                      freshnessPercent: 78,
                      availableUnits: [ProductUnit.packets],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
