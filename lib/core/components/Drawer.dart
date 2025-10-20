import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../constants/constants.dart'; // Pastikan path ini benar

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Fungsi pembangun item menu standar
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? activeColor,
    bool isSelected = false,
  }) {
    final Color color = isSelected ? Colors.white : kTextColor.withOpacity(0.8);
    final Color highlightColor = activeColor ?? kPrimaryColor;
    final Color backgroundColor = isSelected ? highlightColor : kBackgroundColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            leading: Icon(
              icon,
              color: isSelected ? Colors.white : highlightColor,
              size: 24,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionItem({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          leading: Icon(icon, color: kPrimaryColor, size: 24),
          title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          children: children,
        ),
      ),
    );
  }

  Widget _buildSubItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        dense: true,
        title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black)),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top + 8.0),

            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              onTap: () {
                context.go(AppRoutes.home);
              },
              activeColor: kPrimaryColor,
            ),

            // Item Menu 2: Pengaturan (DIRETAIN)
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'Pengaturan',
              onTap: () {
                Navigator.pop(context);
                // context.go(AppRoutes.settings);
              },
              activeColor: kPrimaryColor,
            ),

            // --- Menu Inventory dengan Sub List (ExpansionTile) ---
            _buildExpansionItem(
              icon: Icons.inventory,
              title: 'Inventory',
              children: <Widget>[
                _buildSubItem(
                  title: 'List',
                  onTap: () => context.push(AppRoutes.inventorylist),
                ),
                _buildSubItem(
                  title: 'New',
                  onTap: () => context.push(AppRoutes.inventoryAdd),
                ),
                _buildSubItem(
                  title: 'Edit',
                  onTap: () => Navigator.pop(context),
                ),
                _buildSubItem(
                  title: 'Delete',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(color: Colors.grey, height: 20, indent: 16, endIndent: 16),

            // Contoh Lain (bisa Anda hapus)
            _buildDrawerItem(
              icon: Icons.person_outline,
              title: 'User Profile',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                context.push(AppRoutes.login);
              },
            ),

            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
