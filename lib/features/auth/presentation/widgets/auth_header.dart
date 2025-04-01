import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AuthHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/logo.svg',
          width: 60,
          height: 60,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ],
    );
  }
}
