import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: AppTheme.primaryGradient,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style:TextStyle(
            fontSize: 20.0,fontWeight: FontWeight.bold
          )
        ),
      ],
    );
  }
}


