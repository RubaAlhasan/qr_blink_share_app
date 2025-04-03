import 'package:flutter/material.dart';
import 'package:qr_blink_share_app/core/constants/colors.dart';

import '../../auth/data/repositories/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();

  
  void _logout(BuildContext context) async {
    bool success = await authRepository.logout();
    if(success){
      Navigator.pushReplacementNamed(context, '/');
    }
    
  }

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings, color: AppColors.textColor),
            onSelected: (value) {
              if (value == 'help') {
               // _launchHelpURL();
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'help',
                child: Row(
                  children: [
                    Icon(Icons.help_outline, color: AppColors.primaryColor),
                    SizedBox(width: 12),
                    Text('Help & Support'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppColors.primaryColor),
                    SizedBox(width: 12),
                    Text('Log Out'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Logo and Welcome Message
            Hero(
              tag: 'app-v-logo',
              child: Image.asset(
                'assets/logo.png',
                height: 120,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Create free dynamic QR codes with just a few taps',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w300,
                    
                  )
                ),
                
              ],
            ),
            const SizedBox(height: 40),

            // Action Buttons Column
            Expanded(
              child: ListView(
                children: [
                  _buildActionButton(
                    context,
                    icon: Icons.qr_code_scanner,
                    label: 'Scan QR Code',
                    onPressed: () => Navigator.pushNamed(context, '/scanner'),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.history,
                    label: 'Scan History',
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.add_circle,
                    label: 'Create QR Code',
                    onPressed: () => Navigator.pushNamed(context, '/create'),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.qr_code,
                    label: 'My QR Codes',
                    onPressed: () => Navigator.pushNamed(context, '/mycodes'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          splashColor: AppColors.secondaryColor.withOpacity(0.3),
          highlightColor: AppColors.secondaryColor.withOpacity(0.1),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Row(
              children: [
                Icon(icon, size: 28, color: Colors.white),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, 
                    size: 18, 
                    color: Colors.white.withOpacity(0.7)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}