import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../data/preferences/preference_helper.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/product_card.dart';
import '../../widgets/product_list_tile.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _db = DatabaseHelper.instance;
  final _prefs = PreferenceHelper.instance;
  
  int? _selectedCategoryId;
  String _sortType = 'Default';
  bool _isGrid = true;
  String _userName = 'Guest';

  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  bool _loadingCategories = true;
  bool _loadingProducts = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadData();
  }

  Future<void> _loadPreferences() async {
    try {
      final userName = _prefs.getUserName();
      final lastCategoryId = _prefs.getLastSelectedCategoryId();
      final sortType = _prefs.getProductSortType();
      final viewMode = _prefs.getPreferredViewMode();

      setState(() {
        _userName = userName;
        _selectedCategoryId = lastCategoryId;
        _sortType = _mapSortTypeToDisplay(sortType);
        _isGrid = viewMode == 'grid';
      });
    } catch (e) {
      // Use default values on error
    }
  }

  String _mapSortTypeToDisplay(String sortType) {
    switch (sortType) {
      case 'price_asc':
        return 'Harga terendah';
      case 'price_desc':
        return 'Harga tertinggi';
      default:
        return 'Default';
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _loadingCategories = true;
      _loadingProducts = true;
      _loadError = null;
    });

    await _loadCategories();
    await _loadProducts();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _db.getCategories();
      setState(() {
        _categories = categories;
        _loadingCategories = false;
      });
    } catch (e) {
      setState(() {
        _loadingCategories = false;
        _loadError = 'Data produk gagal dimuat.';
      });
    }
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _db.getProducts();
      setState(() {
        _products = products;
        _loadingProducts = false;
      });
    } catch (e) {
      setState(() {
        _loadingProducts = false;
        _loadError = 'Data produk gagal dimuat.';
      });
    }
  }

  List<ProductModel> get _visibleProducts {
    var products = _selectedCategoryId == null
        ? _products
        : _products
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

  Future<void> _selectCategory(int? categoryId) async {
    setState(() => _selectedCategoryId = categoryId);
    
    // Save to SharedPreferences
    try {
      await _prefs.saveLastSelectedCategoryId(categoryId);
    } catch (e) {
      // Silent fail, not critical
    }
  }

  String _mapDisplayToSortType(String display) {
    switch (display) {
      case 'Harga terendah':
        return 'price_asc';
      case 'Harga tertinggi':
        return 'price_desc';
      default:
        return 'default';
    }
  }

  Future<void> _changeSortType(String? value) async {
    final displayValue = value ?? 'Default';
    setState(() => _sortType = displayValue);

    try {
      await _prefs.saveProductSortType(_mapDisplayToSortType(displayValue));
    } catch (e) {
      // Preference save failure should not block catalog usage.
    }
  }

  Future<void> _toggleViewMode() async {
    final newIsGrid = !_isGrid;
    setState(() => _isGrid = newIsGrid);

    try {
      await _prefs.savePreferredViewMode(newIsGrid ? 'grid' : 'list');
    } catch (e) {
      // Preference save failure should not block catalog usage.
    }
  }

  void _openDetail(ProductModel product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailScreen(productId: product.id!),
      ),
    ).then((_) {
      // Refresh products jika ada perubahan (misal: add to cart)
      _loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingProducts || _loadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return ErrorState(title: _loadError!, onAction: _loadData);
    }

    final products = _visibleProducts;
    
    // Tambahkan "All" category di awal list
    final allCategories = [
      CategoryModel(id: null, name: 'All'),
      ..._categories,
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          'Laviade Studio',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Halo, $_userName. Jelajahi katalog streetwear lokal.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (_categories.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: allCategories.length,
              separatorBuilder: (_, index) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final category = allCategories[index];
                return CategoryChip(
                  label: category.name,
                  isSelected: _selectedCategoryId == category.id,
                  onTap: () => _selectCategory(category.id),
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
                onChanged: _changeSortType,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton.filledTonal(
              tooltip: _isGrid ? 'Tampilan grid' : 'Tampilan list',
              onPressed: _toggleViewMode,
              icon: Icon(_isGrid ? Icons.grid_view : Icons.view_list),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Katalog Produk', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        if (products.isEmpty)
          EmptyState(
            title: 'Belum ada produk.',
            description: _selectedCategoryId == null
                ? 'Tambahkan produk pertama melalui menu Manage.'
                : 'Produk untuk kategori ini belum tersedia.',
            actionLabel: _selectedCategoryId == null
                ? 'Ke Manage Product'
                : 'Tampilkan Semua',
            onAction: () => _selectCategory(null),
          )
        else if (_isGrid)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.64,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                name: product.name,
                categoryName: product.categoryName ?? 'Unknown',
                price: product.price,
                stock: product.stock,
                imageName: product.imageName ?? 'product.png',
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
                categoryName: product.categoryName ?? 'Unknown',
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
