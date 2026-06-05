import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/preference_select.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_name_input.dart';
import '../../widgets/section_title.dart';
import '../../widgets/session_info_card.dart';
import '../../widgets/setting_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Guest',
  );
  bool _isDarkMode = false;
  String _sortType = 'Default';
  String _viewMode = 'Grid';
  String _lastCategory = 'All';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _savePreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferensi berhasil disimpan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = _nameController.text.trim().isEmpty
        ? 'Guest'
        : _nameController.text.trim();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const SectionTitle(
          title: 'Settings',
          subtitle: 'Preferensi dummy untuk 6 key SharedPreferences.',
        ),
        const SizedBox(height: AppSpacing.lg),
        ProfileNameInput(
          controller: _nameController,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.md),
        SettingTile(
          title: 'Dark mode',
          subtitle: 'Representasi key is_dark_mode. Belum mengubah theme real.',
          trailing: Switch(
            value: _isDarkMode,
            onChanged: (value) => setState(() => _isDarkMode = value),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        PreferenceSelect(
          label: 'Kategori terakhir',
          options: const ['All', 'T-Shirt', 'Hoodie', 'Pants'],
          value: _lastCategory,
          onChanged: (value) => setState(() => _lastCategory = value ?? 'All'),
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
          lastCartOpened: 'Belum ada data tersimpan',
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'Keys: user_name, is_dark_mode, last_selected_category_id, product_sort_type, preferred_view_mode, cart_last_opened.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Simpan Preferensi',
          icon: Icons.save_outlined,
          onPressed: _savePreferences,
        ),
      ],
    );
  }
}
