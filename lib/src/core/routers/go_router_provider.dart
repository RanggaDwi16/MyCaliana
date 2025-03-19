import 'package:my_caliana/src/core/provider/shared_pref_provider.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/presentation/check_in/pages/check_in_page.dart';
import 'package:my_caliana/src/presentation/forgot_password/pages/forgot_password_page.dart';
import 'package:my_caliana/src/presentation/home/pages/search_feature_page.dart';
import 'package:my_caliana/src/presentation/login/pages/login_page.dart';
import 'package:my_caliana/src/presentation/main/pages/main_page.dart';
import 'package:my_caliana/src/presentation/notification/pages/notification_page.dart';
import 'package:my_caliana/src/presentation/pra_registration/pages/pra_registration_page.dart';
import 'package:my_caliana/src/presentation/profile/pages/profile_page.dart';
import 'package:my_caliana/src/presentation/registration/pages/confirmation_page.dart';
import 'package:my_caliana/src/presentation/registration/pages/registration_page.dart';
import 'package:my_caliana/src/presentation/splash_screen/pages/splash_screen_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'go_router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) {
  return GoRouter(
    initialLocation: RouterName.splashScreen,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: RouterName.splashScreen,
        builder: (context, state) => const SplashScreenPage(),
      ),
      GoRoute(
        path: '/login',
        name: RouterName.login,
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) async {
          final sharedPrefs = await ref.read(sharedPreferencesProvider.future);
          final isLoggedIn = sharedPrefs.getString('user') != null;

          return isLoggedIn ? RouterName.main : null;
        },
      ),
      GoRoute(
        path: '/main',
        name: RouterName.main,
        builder: (context, state) => const MainPage(),
        // redirect: (context, state) async {
        //   // final sharedPrefs = await ref.read(sharedPreferencesProvider.future);
        //   // final isLoggedIn = sharedPrefs.getString('user') != null;

        //   // return isLoggedIn ? null : '/login';
        // },
      ),
      GoRoute(
        path: '/notification',
        name: RouterName.notification,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/search-fitur',
        name: RouterName.searchFitur,
        builder: (context, state) => const SearchFeaturePage(),
      ),
      GoRoute(
        path: '/registration',
        name: RouterName.registration,
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: '/confirmation',
        name: RouterName.confirmation,
        builder: (context, state) => const ConfirmationPage(),
      ),
      GoRoute(
        path: '/pra-registration',
        name: RouterName.praRegistration,
        builder: (context, state) => const PraRegistrationPage(),
      ),
      GoRoute(
        path: '/check-in',
        name: RouterName.checkIn,
        builder: (context, state) => const CheckInPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: RouterName.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/profile',
        name: RouterName.profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
