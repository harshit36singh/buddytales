import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';

/// Displays the story text in a flat cream card.
class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardCream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.storyLabel.toUpperCase(), style: AppTextStyles.sectionLabel),
              const Icon(
                Icons.menu_book_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(AppStrings.storyText, style: AppTextStyles.storyText),
        ],
      ),
    );
  }
}
