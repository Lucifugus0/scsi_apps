import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/features/auth/screens/LoginScreen.dart';
import '../presentation/features/home/screens/HomeScreen.dart';
import '../presentation/features/Inventory/inventorylist/screens/inventorylist.dart';
import '../presentation/features/Inventory/inventoryadd/screens/inventoryadd.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String inventorylist = '/inventorylist'; // Menambahkan rute Inventory
  static const String inventoryAdd = '/inventoryadd';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    // --- Rute Baru: Inventory List ---
    GoRoute(
      path: AppRoutes.inventorylist,
      name: 'inventorylist',
      builder: (context, state) => const InventoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.inventoryAdd,
      name: 'inventoryadd',
      builder: (context, state) => const InventoryAddScreen(),
    ),

  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Halaman tidak ditemukan: ${state.uri}'),
    ),
  ),
);
