import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/extensions/build_context.ext.dart';
import 'package:my_caliana/src/presentation/registration/provider/registration_provider.dart';
import 'package:my_caliana/src/presentation/registration/widgets/confirmation_dialog_widget.dart';
import 'package:my_caliana/src/presentation/registration/widgets/custom_expansion_tile.dart';
import 'package:my_caliana/src/presentation/registration/widgets/information_widget.dart';

class ConfirmationPage extends HookConsumerWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationData = ref.watch(registrationProvider);
    final kartuController = useTextEditingController(text: '-');
    final nikController = useTextEditingController(text: registrationData!.nik);
    final nomorAksesController =
        useTextEditingController(text: registrationData.nomorAkses);
    final namaController =
        useTextEditingController(text: registrationData.nama);
    final emailController =
        useTextEditingController(text: registrationData.email);
    final personController = useTextEditingController(text: '1');

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          'Konfirmasi Data',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              if (registrationData.nik.isNotEmpty ||
                  registrationData.nomorAkses.isNotEmpty)
                CustomExpansionTile(
                  title: 'Kartu Identitas',
                  children: [
                    InformationWidget(
                      title: 'Kartu Identitas',
                      controller: kartuController,
                      icon: Icons.account_box_outlined,
                    ),
                    const Gap(20),
                    InformationWidget(
                      title: 'Nomor Kartu Identitas',
                      controller: nikController,
                      icon: Icons.account_box_outlined,
                    ),
                    const Gap(20),
                    InformationWidget(
                      title: 'Nomor Akses',
                      controller: nomorAksesController,
                      icon: Icons.account_box_outlined,
                    ),
                  ],
                ),
              const Gap(10),
              CustomExpansionTile(
                title: 'Data Pribadi',
                children: [
                  InformationWidget(
                    title: 'Nama',
                    controller: namaController,
                    icon: Icons.person_outline,
                  ),
                  const Gap(20),
                  InformationWidget(
                    title: 'Email',
                    controller: emailController,
                    icon: Icons.alternate_email_outlined,
                  ),
                ],
              ),
              const Gap(10),
              CustomExpansionTile(title: 'Tujuan Kunjungan', children: [
                InformationWidget(
                  title: 'Berapa banyak orang yang bersama Anda?',
                  controller: personController,
                  icon: Icons.star_border_outlined,
                ),
              ]),
              const Gap(20),
              Button.filled(
                onPressed: () {
                  context.showCustomSnackBar("Check-In Berhasil");

                  context.pushReplacementNamed(RouterName.main);
                },
                label: 'Check In',
              ),
              const Gap(10),
              Button.outlined(
                onPressed: () {
                  showConfirmationBottomSheet(context);
                },
                label: 'Batal',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
