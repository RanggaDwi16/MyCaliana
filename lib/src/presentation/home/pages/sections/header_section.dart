import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_caliana/src/core/helpers/widgets/custom_searchfield.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';

class HeaderSection extends HookWidget {
  final DateTime currentTime;

  const HeaderSection({super.key, required this.currentTime});

  String getFormattedDate() {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getFormattedDate(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const Gap(8),
          Text(
            DateFormat('HH:mm:ss').format(currentTime),
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
          ),
          const Gap(24),
          CustomSearchField(
            hintText: 'Cari',
            onTap: () {
              context.pushNamed(RouterName.searchFitur);
            },
            isReadOnly: true,
          ),
        ],
      ),
    );
  }
}
