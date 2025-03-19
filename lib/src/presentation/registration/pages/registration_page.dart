import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/helpers/widgets/custom_textfield.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/presentation/registration/provider/registration_provider.dart';
import 'package:my_caliana/src/presentation/registration/widgets/confirmation_dialog_widget.dart';

class RegistrationPage extends HookConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final nikController = useTextEditingController();
    final nomorAksesController = useTextEditingController();
    final namaController = useTextEditingController();
    final emailController = useTextEditingController();

    final emailError = ref.watch(emailErrorProvider);
    final isButtonEnabled = ref.watch(isButtonEnabledProvider);

    void validateForm() {
      final isNameFilled = namaController.text.trim().isNotEmpty;
      final isEmailValid = ref.read(emailErrorProvider) == null &&
          emailController.text.isNotEmpty;
      ref.read(isButtonEnabledProvider.notifier).state =
          isNameFilled && isEmailValid;
    }

    /// **Validasi Email**
    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return "Email tidak boleh kosong";
      }
      final isValid =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
              .hasMatch(value);
      final errorMessage = isValid ? null : "Format email tidak valid";
      ref.read(emailErrorProvider.notifier).state = errorMessage;
      validateForm();
      return errorMessage;
    }

    /// **Listener untuk Nama & Email**
    useEffect(() {
      namaController.addListener(validateForm);
      emailController.addListener(() => validateEmail(emailController.text));
      return () {
        namaController.removeListener(validateForm);
        emailController
            .removeListener(() => validateEmail(emailController.text));
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Formulir Registrasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Center(
                    child: Text(
                      'Data Pribadi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Gap(30),
                  CustomTextField(
                    controller: nikController,
                    labelText: 'Nomor Kartu Identitas (tidak wajib diisi)',
                    hintText: 'Masukkan Nomor Kartu Identitas',
                    isRegister: true,
                    prefixIcon: Icons.account_box_outlined,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(20),
                  CustomTextField(
                    controller: nomorAksesController,
                    labelText: 'Nomor Kartu Akses (tidak wajib diisi)',
                    hintText: 'Masukkan Nomor Kartu Akses',
                    isRegister: true,
                    prefixIcon: Icons.account_box_outlined,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(20),
                  CustomTextField(
                    controller: namaController,
                    labelText: 'Nama',
                    hintText: 'Nama',
                    isRegister: true,
                    isRequired: true,
                    prefixIcon: Icons.person_outline,
                  ),
                  const Gap(20),
                  CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Email',
                      isRegister: true,
                      isRequired: true,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.alternate_email_outlined,
                      validator: validateEmail),
                  if (emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                      child: Text(
                        emailError,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const Gap(30),
                  Button.filled(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ref.read(registrationProvider.notifier).state =
                            RegistrationData(
                          nama: namaController.text.trim(),
                          email: emailController.text.trim(),
                          nik: nikController.text.trim(),
                          nomorAkses: nomorAksesController.text.trim(),
                        );

                        context.pushNamed(RouterName.confirmation);
                      }
                    },
                    label: 'Selanjutnya',
                    disabled: !isButtonEnabled,
                  ),
                  const Gap(10),
                  Button.outlined(
                    onPressed: () {
                      showConfirmationBottomSheet(context);
                    },
                    label: 'Kembali',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
