import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';

class InformationWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;

  const InformationWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label di atas
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const Gap(5),

        // Input field dengan icon di kiri
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black87),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
