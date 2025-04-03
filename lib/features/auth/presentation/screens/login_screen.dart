import 'package:flutter/material.dart'; // Add this import
import 'package:qr_blink_share_app/core/constants/colors.dart';
import 'package:qr_blink_share_app/features/auth/data/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();
  bool _obscurePassword = true;
  final bool _isLoading = false;

  Future<void> login() async {
    bool success = await authRepository.login(emailController.text, passwordController.text);
    if (success) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Done")),
      );
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenHeight > 800;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 32, vertical: isLargeScreen ? 20 : 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundColor.withOpacity(0.95),
              AppColors.backgroundColor.withOpacity(0.95),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: isLargeScreen ? 700 : screenHeight * 0.9,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'app-logo',
                    child: Image.asset(
                      'assets/logo.png',
                      height: isLargeScreen ? 140 : 120,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(height: isLargeScreen ? 30 : 20),

                  Column(
                    children: [
                      Text(
                        'Blink Share',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 28 : 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'YOUR THOUGHTS, ONE SCAN AWAY',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isLargeScreen ? 40 : 30),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      labelText: 'Email or UserName',
                      labelStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7)),
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: AppColors.primaryColor),
                      filled: true,
                      fillColor: AppColors.secondaryColor.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: AppColors.textColor),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7)),
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: AppColors.secondaryColor.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        shadowColor: AppColors.primaryColor.withOpacity(0.3),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: isLargeScreen ? 30 : 24),

                  // Corrected Sign Up Prompt using GestureDetector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
