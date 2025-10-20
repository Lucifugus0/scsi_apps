import 'package:flutter/material.dart';
import '../../../../../../core/layout/mainlayout.dart'; // Sesuaikan path MainLayout
import '../components/dropdownfield.dart'; // Sesuaikan path
import '../components/inputfield.dart'; // Sesuaikan path

class InventoryAddScreen extends StatefulWidget {
  const InventoryAddScreen({super.key});

  @override
  State<InventoryAddScreen> createState() => _InventoryAddScreenState();
}

class _InventoryAddScreenState extends State<InventoryAddScreen> {
  String selectedUnit = 'Pcs';

  @override
  Widget build(BuildContext context) {
    return MainLayout( // ✅ Gunakan MainLayout sebagai pembungkus
      title: 'Tambah Item Inventaris', // Judul akan ditampilkan di CustomAppBar
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Nama Item ---
            const StyledInputField(
              label: 'Nama Item',
              hintText: 'e.g. Baut M8 x 20mm',
              isSuccess: false,
              isError: false,
            ),

            // --- Kode SKU (Disabled) ---
            const StyledInputField(
              label: 'Kode SKU',
              hintText: 'SKU dihasilkan otomatis',
              enabled: false,
              isError: false,
            ),

            // --- Kategori ---
            StyledDropdownField(
              label: 'Kategori Item',
              value: 'Electronics',
              items: const ['Electronics', 'Mechanical', 'Chemicals', 'Services'],
              onChanged: (newValue) {
                // Logika ganti kategori
              },
            ),

            // --- Unit ---
            StyledDropdownField(
              label: 'Satuan Unit',
              value: selectedUnit,
              items: const ['Pcs', 'Kg', 'Liter', 'Roll'],
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedUnit = newValue;
                  });
                }
              },
            ),

            // --- Kuantitas Awal (Success) ---
            const StyledInputField(
              label: 'Kuantitas Awal',
              hintText: 'e.g. 100',
              helperText: 'Kuantitas berhasil divalidasi',
              isSuccess: true,
              isError: false,
            ),

            // --- Harga Beli (Error) ---
            const StyledInputField(
              label: 'Harga Beli (Per Unit)',
              hintText: 'e.g. 50000',
              helperText: 'Harga tidak boleh nol',
              isError: true,
              isSuccess: false,
            ),

            // --- Tombol Simpan ---
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Logika Simpan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('SIMPAN ITEM BARU', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}