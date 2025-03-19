import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:my_caliana/src/core/helpers/widgets/buttons.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/constant/path.dart';

class SuccessForgotPasswordPage extends StatelessWidget {
  const SuccessForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacementNamed(RouterName.login);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pushReplacementNamed(RouterName.login),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Email Sudah Terkirim',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(30),
              const Text(
                'Mohon untuk cek kotak masuk email Anda dan klik tautan yang diterima untuk mengatur ulang kata sandi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(PathConstant.successForgotPasswordPath),
              const Gap(20),
              Button.filled(
                onPressed: () => context.pushReplacementNamed(RouterName.login),
                label: 'Masuk',
              ),
              const Gap(40),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: 'Belum dapat email? '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => context
                              .pushReplacementNamed(RouterName.forgotPassword),
                          child: const Text(
                            'Kirim ulang',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
