import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';


class CustomtaskListView extends StatelessWidget {
  const CustomtaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Available TasK Now',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Text(
              '(3)',
              style: TextStyle(
                fontSize: 14,
                color: ColorManger.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Task 1
              Container(
                width: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?q=80&w=2069',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Circuit Breaker Reset',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.near_me,
                              size: 14,
                              color: ColorManger.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '1.2 miles',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorManger.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$45 - \$60',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorManger.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Task 2
              Container(
                width: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1558002038-1055907df827?q=80&w=2070',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Smart Lock Installation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.near_me,
                              size: 14,
                              color: ColorManger.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '2.8 miles',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorManger.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$85 - \$120',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorManger.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
