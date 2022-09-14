import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/app_colors.dart';

Padding statusIndicator({required String label, int? value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$label ",
              style: const TextStyle(
                color: Color(0xff6b6b6b),
                fontSize: 14,
              ),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                color: AppColors.textColorgrey,
                fontSize: 14,
                fontFamily: "Noto Sans",
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        LinearProgressIndicator(
          value: value! / 100,
          backgroundColor: const Color(0xffe8e8e8),
          color: AppColors().getStatusColor(value: value),
        )
      ],
    ),
  );
}
