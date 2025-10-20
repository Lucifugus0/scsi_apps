import 'package:flutter/material.dart';

class StyledInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final Widget? suffixIcon;
  final bool enabled;
  final bool isError;
  final bool isSuccess;

  const StyledInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.helperText,
    this.suffixIcon,
    this.enabled = true,
    this.isError = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Tentukan warna border berdasarkan status
    Color borderColor;
    if (!enabled) {
      borderColor = Colors.grey.shade300;
    } else if (isError) {
      borderColor = Colors.red.shade400;
    } else if (isSuccess) {
      borderColor = Colors.green.shade400;
    } else {
      // Warna default/active
      borderColor = Theme.of(context).primaryColor;
    }

    // 2. Tentukan icon suffix tambahan untuk success/error
    Widget? trailingIcon;
    if (isSuccess) {
      trailingIcon = const Icon(Icons.check_circle_outline, color: Colors.green);
    } else if (isError) {
      trailingIcon = const Icon(Icons.error_outline, color: Colors.red);
    } else if (!enabled) {
      trailingIcon = const Icon(Icons.lock_outline, color: Colors.grey);
    } else {
      trailingIcon = suffixIcon;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Input
        Text(
          label,
          style: TextStyle(
            color: enabled ? Colors.black87 : Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Text Field Utama
        TextFormField(
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: enabled ? Colors.grey.shade400 : Colors.grey.shade500),

            // Border Umum
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),

            // Border Saat Fokus (Menggunakan warna status)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),

            // Border Saat Enabled/Error/Success (Menggunakan warna status)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: isError || isSuccess ? borderColor : Colors.grey.shade300, width: 1.5),
            ),

            // Padding
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

            // Icon Suffix
            suffixIcon: trailingIcon != null
                ? Padding(
              padding: const EdgeInsets.only(right: 15),
              child: trailingIcon,
            )
                : null,
          ),
        ),

        // Helper/Error Text
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 15),
            child: Text(
              helperText!,
              style: TextStyle(
                fontSize: 12,
                color: isError ? Colors.red.shade400 : (isSuccess ? Colors.green.shade400 : Colors.grey.shade600),
              ),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}