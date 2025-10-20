import 'package:flutter/material.dart';
import '../constants/constants.dart'; // Import constants

class OperationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const OperationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Menggunakan LayoutBuilder untuk mendapatkan batasan lebar dari parent
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mendapatkan lebar yang tersedia dari parent (Misal: GridView)
        final double availableWidth = constraints.maxWidth;
        // Menetapkan lebar yang seragam, misal: 150 atau menggunakan lebar maksimum yang tersedia
        final double cardWidth = availableWidth;

        return SizedBox(
          width: cardWidth,
          child: Card(
            color: color.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: InkWell(
              onTap: () {
                // Logika navigasi saat kartu diklik
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigasi ke $title')),
                );
              },
              borderRadius: BorderRadius.circular(kBorderRadius),
              child: Padding(
                padding: const EdgeInsets.all(kPaddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Ikon
                    Container(
                      padding: const EdgeInsets.all(kPaddingSmall),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(kBorderRadius / 2),
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: kPaddingMedium),

                    // Judul & Subjudul
                    Text(
                      title,
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: color.darkerColor(), // Menggunakan ekstensi warna buatan
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Ekstensi untuk mendapatkan warna yang lebih gelap (Digunakan untuk subtitle)
extension ColorExtension on Color {
  Color darkerColor() {
    int r = (red * 0.7).round();
    int g = (green * 0.7).round();
    int b = (blue * 0.7).round();
    return Color.fromARGB(alpha, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255));
  }
}