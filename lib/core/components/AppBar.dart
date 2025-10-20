import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuPressed;
  final bool showProfileButton;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuPressed,
    this.showProfileButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color kPrimaryColor = Theme.of(context).primaryColor;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
      backgroundColor: kBackgroundColor.withOpacity(0.95),
      elevation: 1, // Memberi sedikit bayangan

      leading: IconButton(
        icon: Icon(Icons.menu, color: kPrimaryColor, size: 28),
        onPressed: onMenuPressed, // Panggil fungsi untuk membuka drawer
      ),

      actions: <Widget>[
        if (showProfileButton)
          IconButton(
            icon: Icon(Icons.account_circle, color: kPrimaryColor, size: 28),
            onPressed: () {
              // Navigasi ke halaman profil atau tampilkan menu
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Membuka Halaman Profil...')),
              );
              // Contoh navigasi menggunakan GoRouter:
              // context.go('/profile');
            },
          ),
        const SizedBox(width: kPaddingSmall), // Tambahkan sedikit padding di ujung kanan
      ],
    );
  }

  @override
  // Ukuran standar untuk AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}