import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class ProfileNameInput extends StatelessWidget {
  const ProfileNameInput({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Nama user',
      hintText: 'Guest',
      controller: controller,
      onChanged: onChanged,
    );
  }
}
