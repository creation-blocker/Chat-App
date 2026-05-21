
import 'package:chat_tutorial/controllers/profile_controller.dart';
import 'package:chat_tutorial/routes/app_routes.dart';
import 'package:chat_tutorial/views/auth/forgot_password_view.dart';
import 'package:chat_tutorial/views/auth/login_view.dart';
import 'package:chat_tutorial/views/auth/register_view.dart';
import 'package:chat_tutorial/views/profile/change_password_view.dart';
import 'package:chat_tutorial/views/profile/profile_view.dart';
import 'package:chat_tutorial/views/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.login, page: () => const LoginView()),
    GetPage(name: AppRoutes.register, page: () => const RegisterView()),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView()
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      })
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordView(),
    ),
  ];
}
