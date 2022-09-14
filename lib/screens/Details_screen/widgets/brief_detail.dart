import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

Padding specificDetailsWidget({String? label, String? value}) {
  return Padding(
    padding: const EdgeInsets.only(right: 48.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
            color: Color(0xff6b6b6b),
            fontSize: 12,
            fontFamily: "Noto Sans",
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value!,
          style: const TextStyle(
            color: AppColors.textColorgrey,
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}
