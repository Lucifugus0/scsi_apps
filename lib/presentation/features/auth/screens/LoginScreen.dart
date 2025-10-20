import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../widgets/LoginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan konteks Material (Memperbaiki error No Material Widget Found)
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // Menggunakan SafeArea untuk menghindari takik kamera
      body: SafeArea(
        // SingleChildScrollView mencegah "RenderFlex overflowed" saat keyboard muncul
        child: SingleChildScrollView(
          // Center menengahkan seluruh konten secara horizontal
          child: Center(
            // Column di dalam Center dan SingleChildScrollView aman dari overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize.min memastikan Column hanya selebar yang diperlukan
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // --- Header/Logo (Ikon menu) ---
                Padding(
                  padding: const EdgeInsets.only(left: kPaddingLarge, top: kPaddingLarge, bottom: kPaddingLarge),
                  child: Image.asset(
                    'assets/images/Logo.png', // <-- Path Asset Logo Anda
                    width: 50,
                    height: 50,
                  ),
                ),

                const LoginForm(),

                const SizedBox(height: kPaddingLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
