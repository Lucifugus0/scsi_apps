import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../components/Drawer.dart';
import '../components/AppBar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // GlobalKey untuk Drawer agar bisa dibuka dari IconButton di AppBar
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // Fungsi untuk membuka Drawer (dilewatkan ke CustomAppBar)
    void openDrawer() {
      scaffoldKey.currentState?.openDrawer();
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kBackgroundColor,

      // Sidebar (AppDrawer) dari file yang sudah Anda buat
      drawer: const AppDrawer(),

      // MENGGANTIKAN AppBar standar dengan CustomAppBar
      appBar: CustomAppBar(
        title: title, // Judul dinamis dari halaman
        onMenuPressed: openDrawer, // Melewatkan fungsi openDrawer
        // showProfileButton: false, // Opsi: sembunyikan jika tidak diperlukan di halaman tertentu
      ),

      // Konten utama halaman (child)
      body: SafeArea(
        child: child, // Menampilkan HomeScreen atau InventoryScreen di sini
      ),
    );
  }
}