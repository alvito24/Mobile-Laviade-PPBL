import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class ProductNoteCard extends StatelessWidget {
  const ProductNoteCard({
    super.key,
    required this.noteText,
    required this.createdAt,
    this.onEdit,
    this.onDelete,
  });

  final String noteText;
  final String createdAt;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(noteText, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            createdAt,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              TextButton(onPressed: onEdit, child: const Text('Edit')),
              TextButton(onPressed: onDelete, child: const Text('Hapus')),
            ],
          ),
        ],
      ),
    );
  }
}
