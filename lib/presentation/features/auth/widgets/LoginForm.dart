import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/constants.dart'; // Import constants

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400), // Batas lebar
        margin: const EdgeInsets.all(kPaddingLarge),
        padding: const EdgeInsets.all(kPaddingLarge),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(kBorderRadius * 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: kCardElevation,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Header Text ---
            const Text(
              kWelcomeBack,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            const SizedBox(height: kPaddingSmall / 2),
            const Text(
              kSignInToContinue,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: kPaddingLarge),

            // --- Email Input ---
            const Text(kEmailLabel, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            const SizedBox(height: kPaddingSmall),
            _buildEmailField(),
            const SizedBox(height: kPaddingMedium),

            // --- Password Input ---
            const Text(kPasswordLabel, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            const SizedBox(height: kPaddingSmall),
            _buildPasswordField(),
            const SizedBox(height: kPaddingMedium),

            // --- Checkbox and Forgot Password ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRememberMe(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    kForgotPassword,
                    style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kPaddingMedium),
            ElevatedButton(
              onPressed: () {
                context.push('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: kPaddingMedium),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                elevation: 0,
              ),
              child: const Text(
                kSignIn,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Komponen Input Email
  Widget _buildEmailField() {
    return TextFormField(
      initialValue: 'example@gmail.com',
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
        fillColor: kInputFillColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: kPaddingSmall, horizontal: kPaddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: _isObscure,
      initialValue: '.........',
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
        fillColor: kInputFillColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: kPaddingSmall, horizontal: kPaddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (bool? newValue) {
              setState(() {
                _rememberMe = newValue ?? false;
              });
            },
            activeColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: kPaddingSmall / 2),
        const Text(kRememberMe, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}