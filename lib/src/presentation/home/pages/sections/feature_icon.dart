import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_caliana/src/core/utils/extensions/build_context.ext.dart';
import 'package:my_caliana/src/presentation/home/model/features_icon_model.dart';

class FeatureIconGrid extends StatelessWidget {
  final List<FeaturesIconModel> features;

  const FeatureIconGrid({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final feature = features[index];

        return GestureDetector(
          onTap: () {
            context.showCustomSnackBar("Coming Soon Feature, Stay Tune!");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(feature.icon, size: 32, color: Colors.grey),
              const Gap(8),
              Text(
                feature.label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}
