import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool? isReadOnly;
  final Function(String)? onChanged;
  final Function()? onTap;

  const CustomSearchField({
    super.key,
    this.controller,
    this.hintText = 'Cari',
    this.onChanged,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onTap: onTap,
              readOnly: isReadOnly!,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                isCollapsed: true, // Supaya padding lebih compact
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none, // Hapus border default
                enabledBorder: InputBorder.none,
                focusedBorder:
                    InputBorder.none, // Hapus outline biru saat fokus
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
