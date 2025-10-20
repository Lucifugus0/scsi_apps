import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/inventorylist_model.dart'; // Sesuaikan path model
import '../service/inventorylist_services.dart'; // Sesuaikan path service
import 'package:flutter/foundation.dart'; // Untuk kDebugMode

// 1. Provider untuk InventoryService (Service Instance)
// Gunakan Provider untuk membuat instance service agar mudah diakses dan di-mock.
final inventoryServiceProvider = Provider((ref) => InventoryService());

// 2. Provider untuk mengambil daftar inventaris (Data State)
// Gunakan FutureProvider karena ini adalah operasi asinkron yang mengembalikan List.
final inventoryListProvider = FutureProvider<List<InventorylistModel>>((ref) async {
  try {
    // Ambil instance service dari inventoryServiceProvider
    final service = ref.read(inventoryServiceProvider);

    // Panggil method untuk mengambil daftar inventaris
    final list = await service.fetchInventoryList();

    // Opsional: print untuk konfirmasi di debug mode
    if (kDebugMode) {
      print('✅ INVENTORY_LIST: Fetched ${list.length} items successfully.');
    }

    return list;
  } catch (e, stackTrace) {
    // Menangani error yang dilempar dari InventoryService
    if (kDebugMode) {
      print('❌ INVENTORY_LIST: Failed to fetch inventorylist list: $e');
      // print('❌ INVENTORY_LIST: Stack trace: $stackTrace'); // Biasanya terlalu panjang
    }
    // Melempar kembali exception agar FutureProvider menangkap state error
    throw Exception("Gagal mengambil daftar inventaris: $e");
  }
});