import 'package:flutter/material.dart';

import 'custom_dropdown.dart';

class PreferenceSelect extends StatelessWidget {
  const PreferenceSelect({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      label: label,
      items: options,
      value: value,
      itemLabelBuilder: (item) => item,
      onChanged: onChanged,
    );
  }
}
