import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/helpers/widgets/custom_textfield.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/extensions/build_context.ext.dart';
import 'package:my_caliana/src/presentation/pra_registration/widgets/date_picker_widget.dart';
import 'package:my_caliana/src/presentation/pra_registration/widgets/time_picker_widget.dart';
import 'package:my_caliana/src/presentation/registration/provider/registration_provider.dart';

class PraRegistrationPage extends HookConsumerWidget {
  const PraRegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final namaController = useTextEditingController();
    final emailController = useTextEditingController();
    final tanggalController = useTextEditingController();
    final waktuController = useTextEditingController();

    final emailError = ref.watch(emailErrorProvider);
    final isButtonEnabled = ref.watch(isButtonEnabledProvider);
    final waktuError = useState<String?>(null); // Error state untuk waktu

    void validateForm() {
      final isNameFilled = namaController.text.trim().isNotEmpty;
      final isEmailValid = ref.read(emailErrorProvider) == null &&
          emailController.text.isNotEmpty;
      final isTanggalFilled = tanggalController.text.trim().isNotEmpty;
      final isWaktuFilled = waktuController.text.trim().isNotEmpty;
      final isWaktuValid = waktuError.value == null;
      ref.read(isButtonEnabledProvider.notifier).state = isNameFilled &&
          isEmailValid &&
          isTanggalFilled &&
          isWaktuFilled &&
          isWaktuValid;
    }

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
      tanggalController.addListener(validateForm);
      waktuController.addListener(validateForm);
      return () {
        namaController.removeListener(validateForm);
        emailController
            .removeListener(() => validateEmail(emailController.text));
        tanggalController.removeListener(validateForm);
        waktuController.removeListener(validateForm);
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black26),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          'Formulir Pra Registrasi',
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
                  const Gap(20),
                  CustomTextField(
                    controller: tanggalController,
                    labelText: 'Tanggal Kunjungan',
                    isRequired: true,
                    hintText: 'Pilih Tanggal Kunjungan',
                    prefixIcon: Icons.calendar_today_outlined,
                    isCalendar: true,
                    onTap: () => DatePickerWidget.show(
                        context, tanggalController, validateForm),
                  ),
                  const Gap(20),
                  CustomTextField(
                    controller: waktuController,
                    labelText: 'Waktu Kunjungan',
                    isRequired: true,
                    hintText: 'Pilih Waktu Kunjungan',
                    isCalendar: true,
                    prefixIcon: Icons.access_time_outlined,
                    onTap: () => TimePickerWidget.show(
                        context, waktuController, waktuError, validateForm),
                  ),
                  if (waktuError.value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                      child: Text(
                        waktuError.value!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const Gap(10),
                  const Text(
                      'Rentang waktu kunjungan pengujung : 09.00 - 17.00'),
                  const Gap(30),
                  Button.filled(
                    label: 'Kirim Undangan',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.showCustomSnackBar("Kirim Undangan Berhasil");
                        context.pushNamed(RouterName.main);
                      }
                    },
                    disabled: !isButtonEnabled,
                  ),
                  const Gap(10),
                  Button.outlined(
                    label: 'Batal',
                    onPressed: () {
                      context.pop();
                    },
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
