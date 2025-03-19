import 'package:flutter/material.dart';

class FeaturesIconModel {
  final String label;
  final IconData icon;

  FeaturesIconModel({required this.label, required this.icon});
}

final List<String> listCategoryFeatures = [
  'Semua Fitur',
  'Visitor Management System',
  'Access Control System'
];

final List<FeaturesIconModel> allFeatures = [
  FeaturesIconModel(label: 'Dasbor', icon: Icons.insert_chart_outlined),
  FeaturesIconModel(label: 'Daftar Pengunjung', icon: Icons.switch_account),
  FeaturesIconModel(label: 'Residen', icon: Icons.home_outlined),
];

final List<FeaturesIconModel> visitorFeatures = [
  FeaturesIconModel(label: 'Dasbor', icon: Icons.insert_chart_outlined),
  FeaturesIconModel(label: 'Daftar Pengunjung', icon: Icons.switch_account),
  FeaturesIconModel(label: 'Residen', icon: Icons.home_outlined),
];

final List<FeaturesIconModel> accessControlFeatures = [
  FeaturesIconModel(label: 'Dasbor', icon: Icons.insert_chart_outlined),
];
