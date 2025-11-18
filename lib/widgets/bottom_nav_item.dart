// lib/widgets/bottom_nav_item.dart
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const BottomNavItem(
      {required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? Colors.purple.shade900 : Colors.grey.shade600,
            size: 26,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selected ? Colors.purple.shade900 : Colors.grey.shade600,
            ),
          )
        ],
      ),
    );
  }
}