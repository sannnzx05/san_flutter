
import 'package:flutter/material.dart';

class BarisInfo extends StatelessWidget {
  final IconData ikon;
  final String label;
  final String nilai;

  const BarisInfo({
    super.key,
    required this.ikon,
    required this.label,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ikon,
            color: Colors.teal,
            size: 22,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(nilai),
          ),
        ],
      ),
    );
  }
}
