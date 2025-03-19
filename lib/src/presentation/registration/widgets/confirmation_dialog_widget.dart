import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';

void showConfirmationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.0),
      ),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Semua data tidak akan disimpan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Yakin ingin membatalkan?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Button.outlined(
                  onPressed: () {
                    context.pushReplacementNamed(RouterName.main);
                  },
                  label: 'Ya, batalkan',
                ),
              ),
              const Gap(8),
              Expanded(
                child: Button.filled(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'Tidak, kembali',
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
