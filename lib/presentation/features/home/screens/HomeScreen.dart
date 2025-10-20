import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/layout/mainlayout.dart';
import '../../../../core/components/Card.dart';
import '../../../../core/components/SectionTitle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Contoh data untuk bagian Operations
  final List<Map<String, dynamic>> operations = const [
    {'title': 'Cycle Count', 'subtitle': '3 Open Projects', 'icon': Icons.sync, 'color': Color(0xFFFFA726)}, // Orange
    {'title': 'Receiving', 'subtitle': '3 Open Projects', 'icon': Icons.input, 'color': Color(0xFF4DB6AC)}, // Teal
    {'title': 'Transfer', 'subtitle': '3 Open Projects', 'icon': Icons.compare_arrows, 'color': Color(0xFF7E57C2)}, // Deep Purple
    {'title': 'Adjustment', 'subtitle': '3 Open Projects', 'icon': Icons.swap_vert, 'color': Color(0xFFEC407A)}, // Pink
  ];

  // Contoh data untuk bagian Inventory
  final List<Map<String, dynamic>> inventoryItems = const [
    {'title': 'Master Item', 'icon': Icons.inventory},
    {'title': 'QOH', 'icon': Icons.bar_chart},
    {'title': 'Printing', 'icon': Icons.print},
    {'title': 'Item Locator', 'icon': Icons.location_on},
  ];

  @override
  Widget build(BuildContext context) {
    // Tidak perlu GlobalKey<ScaffoldState> di sini karena MainLayout seharusnya mengelolanya

    return MainLayout(
      title: 'Dashboard',
      child: SingleChildScrollView(
        // Padding luar yang lebih baik
        padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: kPaddingLarge),

            // --- Bagian Header/Sapaan ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
              child: Text(
                'Welcome, User',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  // Menggunakan warna primer atau kTextColor yang lebih jelas
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: kPaddingLarge),

            // --- Title: OPERATIONS ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingSmall),
              child: SectionTitle('OPERATIONS'),
            ),
            const SizedBox(height: kPaddingMedium),

            // --- Grid Operasi (RESPONSIVE) ---
            // Menggunakan LayoutBuilder agar GridView tahu lebar layar yang tersedia
            LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // ✅ MENENTUKAN 2 KOTAK PER BARIS
                    crossAxisSpacing: kPaddingSmall, // Spasi horizontal
                    mainAxisSpacing: kPaddingSmall, // Spasi vertikal
                    childAspectRatio: 1.2,
                  ),
                  itemCount: operations.length,
                  itemBuilder: (context, index) {
                    final op = operations[index];
                    return OperationCard(
                      title: op['title']!,
                      subtitle: op['subtitle']!,
                      icon: op['icon']!,
                      color: op['color']!,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: kPaddingLarge),

            // --- Title: INVENTORY ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingSmall),
              child: SectionTitle('INVENTORY'),
            ),
            const SizedBox(height: kPaddingMedium),

            // --- Daftar Inventory ---
            Container(
              // Padding ini untuk menyeimbangkan dengan Padding utama SingleChildScrollView
              padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Gunakan warna putih untuk kontras yang lebih baik
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08), // Bayangan yang lebih jelas
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: inventoryItems.length,
                  separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey.shade200, // Warna pemisah yang lebih halus
                      indent: kPaddingMedium,
                      endIndent: kPaddingMedium),
                  itemBuilder: (context, index) {
                    final item = inventoryItems[index];
                    return ListTile(
                      leading: Icon(item['icon'] as IconData,
                          color: Theme.of(context).primaryColor), // Gunakan primary color
                      title: Text(item['title'] as String),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Navigasi ke ${item['title']}')),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // Tambahkan padding di bagian bawah agar tidak terlalu mepet
            const SizedBox(height: kPaddingLarge * 2),
          ],
        ),
      ),
    );
  }
}