import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/presentation/home/model/features_icon_model.dart';
import 'package:my_caliana/src/presentation/home/pages/sections/feature_icon.dart';


class FeatureSection extends StatefulWidget {
  const FeatureSection({super.key});

  @override
  State<FeatureSection> createState() => _FeatureSectionState();
}

class _FeatureSectionState extends State<FeatureSection> {
  int activeTabIndex = 0;

  /// **Mengambil daftar fitur berdasarkan kategori yang dipilih**
  List<FeaturesIconModel> getSelectedFeatures() {
    if (activeTabIndex == 0) return allFeatures; // Semua Fitur
    if (activeTabIndex == 1) return visitorFeatures; // Visitor Management System
    if (activeTabIndex == 2) return accessControlFeatures; // Access Control System
    return allFeatures;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fitur',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const Gap(16),

          /// **Kategori Fitur**
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final isActive = index == activeTabIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTabIndex = index;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      listCategoryFeatures[index],
                      style: TextStyle(
                          color: isActive ? AppColor.primaryColor : Colors.grey,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Gap(16),
              itemCount: listCategoryFeatures.length,
            ),
          ),
          const Gap(16),

          /// **Grid Fitur**
          FeatureIconGrid(features: getSelectedFeatures()),
        ],
      ),
    );
  }
}