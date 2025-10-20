import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import '../../../../../core/constants/constants.dart';
import '../../../../../core/layout/mainlayout.dart';
import '../components/inventoryitemlist.dart';
import '../models/inventorylist_model.dart';
import '../riverpod/inventorylist_riverpod.dart';

// Ubah menjadi ConsumerWidget
class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Tambahkan WidgetRef ref
    // kPrimaryColor diambil dari tema
    final Color kPrimaryColor = Theme.of(context).primaryColor;
    final bool isDesktop = MediaQuery.of(context).size.width > 800;

    // 1. WATCH provider untuk mendapatkan data
    final inventoryListAsync = ref.watch(inventoryListProvider);

    return MainLayout(
      title: 'Inventory Management',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingMedium),
          // Gunakan RefreshIndicator untuk me-reload data
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(inventoryListProvider.future),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Penting untuk RefreshIndicator
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSearchBar(isDesktop, kPrimaryColor),
                  const SizedBox(height: kPaddingMedium),
                  Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadius)),
                    child: Padding(
                      padding: const EdgeInsets.all(kPaddingMedium),
                      // 2. Kirim AsyncValue ke method yang akan menangani state
                      child: _buildInventoryList(inventoryListAsync),
                    ),
                  ),

                  const SizedBox(height: kPaddingMedium),

                  // --- Pagination (Hanya tampil di Desktop) ---
                  if (isDesktop) _buildPagination(kPrimaryColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Ganti _buildMobileList dengan _buildInventoryList untuk menangani AsyncValue
  Widget _buildInventoryList(AsyncValue<List<InventorylistModel>> inventoryListAsync) {
    // Gunakan .when() untuk menangani 3 state (Loading, Error, Data)
    return inventoryListAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            '⚠️ Gagal memuat data inventaris.\n${err.toString()}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
      data: (inventoryList) {
        if (inventoryList.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: Text('Tidak ada data inventaris yang ditemukan.')),
          );
        }

        // Tampilkan list data yang didapatkan dari API
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: inventoryList.length,
          itemBuilder: (context, index) {
            return InventoryItemList(item: inventoryList[index]);
          },
        );
      },
    );
  }


  // --- Helper Methods (Tidak Berubah) ---

  Widget _buildSearchBar(bool isDesktop, Color kPrimaryColor) {
    // ... (Kode _buildSearchBar tetap sama)
    final Widget searchFieldWidget = Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search Inventory...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        ),
      ),
    );

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: kPaddingLarge),
          Expanded(child: searchFieldWidget),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kPaddingMedium),
          searchFieldWidget,
        ],
      );
    }
  }

  // Komponen Pagination
  Widget _buildPagination(Color kPrimaryColor) {
    // ... (Kode _buildPagination tetap sama)
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text('Tampilkan:'),
            const SizedBox(width: kPaddingSmall),
            DropdownButton<String>(
              value: '5',
              items: ['5', '10', '25'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ],
        ),
        Row(
          children: [
            _buildPaginationButton(Icons.chevron_left, () {}, false),
            _buildPaginationNumber('1', kPrimaryColor, true),
            _buildPaginationNumber('2', kPrimaryColor),
            _buildPaginationNumber('3', kPrimaryColor),
            const Text('...'),
            _buildPaginationNumber('1015', kPrimaryColor),
            _buildPaginationButton(Icons.chevron_right, () {}, false),
          ],
        ),
      ],
    );
  }

  // Helper untuk tombol Pagination
  Widget _buildPaginationButton(IconData icon, VoidCallback onPressed, bool disabled) {
    // ... (Kode _buildPaginationButton tetap sama)
    return IconButton(
      icon: Icon(icon, size: 20, color: disabled ? Colors.grey : Colors.black),
      onPressed: disabled ? null : onPressed,
    );
  }

  // Helper untuk angka Pagination
  Widget _buildPaginationNumber(String number, Color kPrimaryColor, [bool isSelected = false]) {
    // ... (Kode _buildPaginationNumber tetap sama)
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? kPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}