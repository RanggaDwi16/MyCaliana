import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/constant/path.dart';
import 'package:my_caliana/src/core/utils/extensions/build_context.ext.dart';
import 'package:my_caliana/src/presentation/login/provider/user_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider); // Ambil data dari SharedPreferences

    final String userName = user?.fullName ?? "Memuat...";
    final String userEmail = user?.email ?? "Memuat...";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(PathConstant.avatarPath),
                  ),
                  const SizedBox(height: 16),
                  // Nama pengguna
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Email pengguna
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuSection(
                    context,
                    items: [
                      _buildMenuItem(context,
                          icon: Icons.person_outline,
                          title: 'Data Diri',
                          onTap: () => context.showCustomSnackBar(
                              "Coming Soon Feature, Stay Tune!")),
                      Divider(height: 1, color: Colors.grey.withOpacity(0.5)),
                      _buildMenuItem(context,
                          icon: Icons.settings_outlined,
                          title: 'Pengaturan',
                          onTap: () => context.showCustomSnackBar(
                              "Coming Soon Feature, Stay Tune!")),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildMenuSection(
                    context,
                    items: [
                      _buildMenuItem(context,
                          icon: Icons.help_outline,
                          title: 'Bantuan',
                          onTap: () => context.showCustomSnackBar(
                              "Coming Soon Feature, Stay Tune!")),
                      Divider(height: 1, color: Colors.grey.withOpacity(0.5)),
                      _buildMenuItem(
                        context,
                        icon: Icons.logout_outlined,
                        title: 'Keluar',
                        onTap: () {
                          _showConfirmationBottomSheet(context, ref);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context,
      {required List<Widget> items}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.grey),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.primaryColor),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              color: AppColor.primaryColor, size: 16),
          onTap: onTap,
        ),
      ],
    );
  }

  void _showConfirmationBottomSheet(BuildContext context, WidgetRef ref) {
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
              'Yakin ingin keluar?',
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
                      ref.read(userProvider.notifier).logout();
                      context.pushReplacementNamed(RouterName.login);
                    },
                    label: 'Ya, Keluar',
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
}
