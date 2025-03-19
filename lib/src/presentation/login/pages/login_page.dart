import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/helpers/widgets/custom_textfield.dart';
import 'package:my_caliana/src/core/model/user_model.dart';
import 'package:my_caliana/src/core/provider/shared_pref_provider.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/extensions/build_context.ext.dart';
import 'package:my_caliana/src/presentation/login/provider/user_provider.dart';
import 'package:my_caliana/src/presentation/login/widgets/image_slider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final isLoading = useState(false);

    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);

    final sharedPrefsAsync = ref.watch(sharedPreferencesProvider);

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

    /// **Validasi Password**
    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        passwordError.value = "Kata sandi harus diisi";
      } else if (value.length < 6) {
        passwordError.value = "Kata sandi terlalu pendek";
      } else {
        passwordError.value = null;
      }
      return passwordError.value;
    }

    return sharedPrefsAsync.when(
      data: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ColorfulSafeArea(
              color: AppColor.colorSafeArea,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double keyboardHeight =
                      MediaQuery.of(context).viewInsets.bottom;
                  double availableHeight =
                      constraints.maxHeight - keyboardHeight;

                  return Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: keyboardHeight > 0
                              ? availableHeight * 0.3
                              : availableHeight * 0.5,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: keyboardHeight > 0
                                  ? availableHeight * 0.3
                                  : availableHeight * 0.5,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 500),
                              autoPlayCurve: Curves.fastOutSlowIn,
                            ),
                            items: imageSlider.map((path) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Image.asset(
                                    path,
                                    fit: BoxFit.cover,
                                    width: context.deviceWidth,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: keyboardHeight > 0
                            ? availableHeight * 0.25
                            : availableHeight * 0.5 - 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 12.0),
                                    child: Text(
                                      emailError.value!,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                const Gap(20),
                                CustomTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  labelText: "Kata Sandi",
                                  hintText: "********",
                                  obscureText: !isPasswordVisible.value,
                                  prefixIcon: Icons.lock_outline,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      isPasswordVisible.value =
                                          !isPasswordVisible.value;
                                    },
                                  ),
                                  validator: validatePassword,
                                ),
                                if (passwordError.value != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 12.0),
                                    child: Text(
                                      passwordError.value!,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                const Gap(20),
                                const Text(
                                  'Lupa kata sandi?',
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColor.primaryColor,
                                  ),
                                ),
                                const Gap(40),
                                Button.filled(
                                  onPressed: () async {
                                    bool isEmailValid =
                                        validateEmail(emailController.text) ==
                                            null;
                                    bool isPasswordValid = validatePassword(
                                            passwordController.text) ==
                                        null;

                                    if (!isEmailValid || !isPasswordValid) {
                                      return;
                                    }

                                    final user = UserModel.sampleUser;
                                    if (emailController.text == user.email &&
                                        passwordController.text ==
                                            user.password) {
                                      isLoading.value = true;

                                      await ref
                                          .read(userProvider.notifier)
                                          .saveUser(user);

                                      isLoading.value = false;
                                      context.pushReplacementNamed(
                                          RouterName.main);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Tidak bisa login, email atau password salah",
                                            style: TextStyle(
                                                color: AppColor.blackColor),
                                          ),
                                          backgroundColor: AppColor.whiteColor,
                                        ),
                                      );
                                    }
                                  },
                                  label: 'Masuk',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }
}
