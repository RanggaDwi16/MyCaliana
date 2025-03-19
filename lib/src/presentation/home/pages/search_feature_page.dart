import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_caliana/src/core/helpers/widgets/custom_searchfield.dart';
import 'package:my_caliana/src/presentation/home/model/features_icon_model.dart';
import 'package:my_caliana/src/presentation/home/pages/sections/feature_icon.dart';

class SearchFeaturePage extends HookWidget {
  const SearchFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final searchText = useState("");

    /// **Filter fitur berdasarkan input pencarian**
    List<FeaturesIconModel> filteredFeatures = searchText.value.isNotEmpty
        ? allFeatures
            .where((feature) => feature.label
                .toLowerCase()
                .contains(searchText.value.toLowerCase()))
            .toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cari Fitur',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// **Kolom Pencarian**
            CustomSearchField(
              hintText: 'Cari fitur',
              controller: searchController,
              onChanged: (value) {
                searchText.value = value; // Update state pencarian
              },
            ),
            const Gap(16),

            /// **Grid Fitur yang Terfilter**
            Expanded(
              child: searchText.value.isNotEmpty
                  ? (filteredFeatures.isNotEmpty
                      ? FeatureIconGrid(features: filteredFeatures)
                      : const Center(
                          child: Text(
                            "Fitur tidak ditemukan",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ))
                  : const Center(
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
