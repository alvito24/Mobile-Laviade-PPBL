import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/dummy_data.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/product_card.dart';
import '../../widgets/product_list_tile.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryId = 0;
  String _sortType = 'Default';
  bool _isGrid = true;

  List<DummyProduct> get _visibleProducts {
    final products = _selectedCategoryId == 0
        ? DummyData.products
        : DummyData.products
              .where((product) => product.categoryId == _selectedCategoryId)
              .toList();

    final sorted = [...products];
    if (_sortType == 'Harga terendah') {
      sorted.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortType == 'Harga tertinggi') {
      sorted.sort((a, b) => b.price.compareTo(a.price));
    }
    return sorted;
  }

  void _openDetail(DummyProduct product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _visibleProducts;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          'Laviade Studio',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Halo, Guest. Jelajahi katalog streetwear lokal.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: DummyData.categories.length,
            separatorBuilder: (_, index) =>
                const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final category = DummyData.categories[index];
              return CategoryChip(
                label: category.name,
                isSelected: _selectedCategoryId == category.id,
                onTap: () => setState(() => _selectedCategoryId = category.id),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: CustomDropdown<String>(
                label: 'Sort produk',
                items: const ['Default', 'Harga terendah', 'Harga tertinggi'],
                value: _sortType,
                itemLabelBuilder: (item) => item,
                onChanged: (value) =>
                    setState(() => _sortType = value ?? 'Default'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton.filledTonal(
              tooltip: _isGrid ? 'Tampilan grid' : 'Tampilan list',
              onPressed: () => setState(() => _isGrid = !_isGrid),
              icon: Icon(_isGrid ? Icons.grid_view : Icons.view_list),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Katalog Produk', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        if (_isGrid)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                name: product.name,
                categoryName: product.categoryName,
                price: product.price,
                stock: product.stock,
                imageName: product.imageName,
                onTap: () => _openDetail(product),
              );
            },
          )
        else
          ...products.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ProductListTile(
                name: product.name,
                categoryName: product.categoryName,
                price: product.price,
                stock: product.stock,
                onTap: () => _openDetail(product),
              ),
            ),
          ),
      ],
    );
  }
}
