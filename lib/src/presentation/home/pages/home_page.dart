import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/presentation/home/pages/sections/feature_section.dart';
import 'package:my_caliana/src/presentation/home/pages/sections/header_section.dart';
import 'package:my_caliana/src/presentation/home/pages/sections/visitor_section.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startLiveClock();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startLiveClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Bagian Header
              HeaderSection(currentTime: _currentTime),

              /// Bagian Fitur
              const FeatureSection(),

              /// Bagian Pengunjung Hari Ini
              const VisitorSection(),
            ],
          ),
        ),
      ),
    );
  }
}
