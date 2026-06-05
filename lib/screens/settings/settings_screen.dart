import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../data/preferences/preference_helper.dart';
import '../../models/category_model.dart';
import '../../widgets/preference_select.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_name_input.dart';
import '../../widgets/section_title.dart';
import '../../widgets/session_info_card.dart';
import '../../widgets/setting_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.onThemeChanged});

  final VoidCallback? onThemeChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _prefs = PreferenceHelper.instance;
  final _db = DatabaseHelper.instance;
  
  late final TextEditingController _nameController;
  bool _isDarkMode = false;
  String _sortType = 'Default';
  String _viewMode = 'Grid';
  int? _lastCategoryId;
  
  List<CategoryModel> _categories = [];
  bool _loading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadPreferences();
    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _db.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      // Silent fail, categories optional for display
    }
  }

  Future<void> _loadPreferences() async {
    setState(() => _loading = true);
    
    try {
      final userName = _prefs.getUserName();
      final isDarkMode = _prefs.getDarkMode();
      final sortType = _prefs.getProductSortType();
      final viewMode = _prefs.getPreferredViewMode();
      final categoryId = _prefs.getLastSelectedCategoryId();

      _nameController.text = userName;
      
      setState(() {
        _isDarkMode = isDarkMode;
        _sortType = _mapSortTypeToDisplay(sortType);
        _viewMode = viewMode == 'grid' ? 'Grid' : 'List';
        _lastCategoryId = categoryId;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal memuat preferensi: $e')),
        );
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

  Future<void> _savePreferences() async {
    if (_isSaving) return;
    
    setState(() => _isSaving = true);

    try {
      final userName = _nameController.text.trim();
      final sortType = _mapDisplayToSortType(_sortType);
      final viewMode = _viewMode.toLowerCase();

      await _prefs.saveUserName(userName.isEmpty ? 'Guest' : userName);
      await _prefs.saveDarkMode(_isDarkMode);
      await _prefs.saveProductSortType(sortType);
      await _prefs.savePreferredViewMode(viewMode);
      await _prefs.saveLastSelectedCategoryId(_lastCategoryId);

      if (!mounted) return;

      // Notify parent to update theme if dark mode changed
      widget.onThemeChanged?.call();

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Preferensi berhasil disimpan.')),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menyimpan preferensi: $e')),
        );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  String _getCategoryName(int? categoryId) {
    if (categoryId == null) return 'All';
    
    try {
      final category = _categories.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => CategoryModel(id: null, name: 'All'),
      );
      return category.name;
    } catch (e) {
      return 'All';
    }
  }

  String _formatCartLastOpened() {
    final lastOpened = _prefs.getCartLastOpened();
    if (lastOpened == null || lastOpened.isEmpty) {
      return 'Belum pernah membuka cart';
    }

    try {
      final dateTime = DateTime.parse(lastOpened);
      final formatter = DateFormat('dd MMM yyyy, HH:mm');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Data tidak valid';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final userName = _nameController.text.trim().isEmpty
        ? 'Guest'
        : _nameController.text.trim();

    // Build category options for dropdown
    final categoryOptions = [
      'All',
      ..._categories.map((cat) => cat.name),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const SectionTitle(
          title: 'Settings',
          subtitle: 'Kelola preferensi aplikasi dengan SharedPreferences.',
        ),
        const SizedBox(height: AppSpacing.lg),
        ProfileNameInput(
          controller: _nameController,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.md),
        SettingTile(
          title: 'Dark mode',
          subtitle: 'Aktifkan tema gelap untuk kenyamanan mata.',
          trailing: Switch(
            value: _isDarkMode,
            onChanged: (value) => setState(() => _isDarkMode = value),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        PreferenceSelect(
          label: 'Kategori terakhir dipilih',
          options: categoryOptions,
          value: _getCategoryName(_lastCategoryId),
          onChanged: (value) {
            if (value == null || value == 'All') {
              setState(() => _lastCategoryId = null);
              return;
            }
            
            final category = _categories.firstWhere(
              (cat) => cat.name == value,
              orElse: () => CategoryModel(id: null, name: 'All'),
            );
            setState(() => _lastCategoryId = category.id);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        PreferenceSelect(
          label: 'Sort produk',
          options: const ['Default', 'Harga terendah', 'Harga tertinggi'],
          value: _sortType,
          onChanged: (value) => setState(() => _sortType = value ?? 'Default'),
        ),
        const SizedBox(height: AppSpacing.md),
        PreferenceSelect(
          label: 'Tampilan katalog',
          options: const ['Grid', 'List'],
          value: _viewMode,
          onChanged: (value) => setState(() => _viewMode = value ?? 'Grid'),
        ),
        const SizedBox(height: AppSpacing.md),
        SessionInfoCard(
          userName: userName,
          lastCartOpened: _formatCartLastOpened(),
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'Keys: user_name, is_dark_mode, last_selected_category_id, product_sort_type, preferred_view_mode, cart_last_opened.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: _isSaving ? 'Menyimpan...' : 'Simpan Preferensi',
          icon: Icons.save_outlined,
          onPressed: _isSaving ? null : _savePreferences,
        ),
      ],
    );
  }
}
