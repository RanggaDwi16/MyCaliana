import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';

class VisitorSection extends StatelessWidget {
  const VisitorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hari Ini',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const Gap(32),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Belum Ada Pengunjung Baru',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w700)),
                Text('Pengunjung menunggu akan ditampilkan disini',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey)),
                const Gap(12),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Button.outlined(
                    onPressed: () {},
                    label: 'Refresh',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
