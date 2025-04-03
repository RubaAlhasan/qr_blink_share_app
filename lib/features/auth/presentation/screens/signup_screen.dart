import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:qr_blink_share_app/core/constants/colors.dart';
import '../../data/repositories/auth_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthRepository authRepository = AuthRepository();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final form = FormGroup({
    'userName': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
    'emailAddress': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
    'confirmPassword': FormControl<String>(
      validators: [Validators.required],
    ),
  }, validators: [
    Validators.mustMatch('password', 'confirmPassword')
  ]);

  Future<void> _signUp(BuildContext context) async {
    if (form.valid) {
      setState(() => _isLoading = true);
      try {
        bool success = await authRepository.register(
          userName: form.control('userName').value,
          emailAddress: form.control('emailAddress').value,
          password: form.control('password').value,
        );
        if (success) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/login');
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration Failed")),
          );
        }
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      form.markAllAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenHeight > 800;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: isLargeScreen ? 20 : 0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // ignore: deprecated_member_use
              AppColors.backgroundColor.withOpacity(0.95),
              // ignore: deprecated_member_use
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
              maxHeight: isLargeScreen ? 800 : screenHeight * 0.9,
            ),
            child: SingleChildScrollView(
              child: ReactiveForm(
                formGroup: form,
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

                    // Username Field
                    ReactiveTextField<String>(
                      formControlName: 'userName',
                      style: const TextStyle(color: AppColors.textColor),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: AppColors.textColor.withOpacity(0.7)),
                        prefixIcon: const Icon(Icons.person_outline,
                            color: AppColors.primaryColor),
                        filled: true,
                        fillColor: AppColors.secondaryColor.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                      ),
                      validationMessages: {
                        'required': (_) => 'Username is required',
                        'minLength': (_) => 'Minimum 3 characters',
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    ReactiveTextField<String>(
                      formControlName: 'emailAddress',
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: AppColors.textColor),
                      decoration: InputDecoration(
                        labelText: 'Email Address',
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                      ),
                      validationMessages: {
                        'required': (_) => 'Email is required',
                        'email': (_) => 'Enter a valid email',
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    ReactiveTextField<String>(
                      formControlName: 'password',
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                      ),
                      validationMessages: {
                        'required': (_) => 'Password is required',
                        'minLength': (_) => 'Minimum 6 characters',
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    ReactiveTextField<String>(
                      formControlName: 'confirmPassword',
                      obscureText: _obscureConfirmPassword,
                      style: const TextStyle(color: AppColors.textColor),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                            color: AppColors.textColor.withOpacity(0.7)),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: AppColors.primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () => setState(() =>
                              _obscureConfirmPassword = !_obscureConfirmPassword),
                        ),
                        filled: true,
                        fillColor: AppColors.secondaryColor.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                      ),
                      validationMessages: {
                        'required': (_) => 'Please confirm your password',
                        'mustMatch': (_) => 'Passwords do not match',
                      },
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _signUp(context),
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
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: isLargeScreen ? 30 : 24),

                    // Login Prompt
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/login'),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}