import 'package:flutter/material.dart';
import '../services/auth_api_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Define the form structure
  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email, // Validate email pattern
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8), // Password must be at least 8 characters
      ],
    ),
  });

  Future<void> login(BuildContext context) async {
    if (form.valid) {
      final email = form.control('email').value;
      final password = form.control('password').value;

      final response = await AuthApiService.login(email, password);

      if (response['success']) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomeScreen()),
        // );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } else {
      form.markAllAsTouched(); // Show errors for all fields
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ReactiveForm(
            formGroup: form, // Attach form group
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF77F00)),
                ),
                const SizedBox(height: 20),

                /// **Email Field**
                ReactiveTextField<String>(
                  formControlName: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => 'Email is required',
                    ValidationMessage.email: (_) =>
                        'Enter a valid email address',
                  },
                ),
                const SizedBox(height: 10),

                /// **Password Field**
                ReactiveTextField<String>(
                  formControlName: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => 'Password is required',
                    ValidationMessage.minLength: (_) =>
                        'Password must be at least 8 characters',
                  },
                ),
                const SizedBox(height: 20),

                /// **Login Button**
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return ElevatedButton(
                      onPressed: form.valid
                          ? () => login(context)
                          : null, // Disable if invalid
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF77F00),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      child: const Text("Login",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
