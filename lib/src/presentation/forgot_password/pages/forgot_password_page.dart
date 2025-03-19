import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/helpers/widgets/custom_textfield.dart';
import 'package:my_caliana/src/core/model/user_model.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/constant/path.dart';

class ForgotPasswordPage extends HookConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final emailError = useState<String?>(null);

    /// **Validasi Email**
    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        emailError.value = "Email harus diisi";
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
        emailError.value = "Format email tidak valid";
      } else {
        emailError.value = null;
      }
      return emailError.value;
    }

    return WillPopScope(
      onWillPop: () async {
        context.pushReplacementNamed(RouterName.login);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
          backgroundColor: AppColor.whiteColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Lupa Kata Sandi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(20),
                const Text(
                  'Masukkan email alamat Anda di bawah ini dan kami akan mengirimkan tautan untuk mengatur ulang kata sandi Anda.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Image.asset(PathConstant.forgotPasswordPath),
                const Gap(40),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email",
                  hintText: "example@callana.id",
                  prefixIcon: Icons.alternate_email_outlined,
                  validator: validateEmail,
                ),
                if (emailError.value != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                    child: Text(
                      emailError.value!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const Gap(40),
                Button.filled(
                  onPressed: () async {
                    bool isEmailValid =
                        validateEmail(emailController.text) == null;

                    if (!isEmailValid) {
                      return;
                    }

                    final user = UserModel.sampleUser;
                    if (emailController.text == user.email) {
                      context.pushNamed(RouterName.successForgotPassword);
                    } else {
                      emailError.value = "Email tidak terdaftar";
                    }
                  },
                  label: 'Masuk',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
