import 'package:flutter/material.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/chat/presentation/pages/chat.dart';
import 'package:mobile/features/onboarding/presentation/pages/login.dart';
import 'package:mobile/features/onboarding/presentation/pages/phone.verification.dart';
import 'package:mobile/features/onboarding/presentation/pages/register.dart';
import 'package:mobile/features/real_estate/presentation/pages/dashboard.dart';
import 'package:mobile/features/shared/presentation/pages/welcome.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_utils/shared_utils.dart';

class AppRouterConfig {
  static Route<dynamic>? setupRoutes(RouteSettings settings) {
    switch (settings.name) {
      /// region onboarding
      case AppRouter.welcomeRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => const WelcomePage(), settings: settings);
      case AppRouter.loginRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => const LoginPage(), settings: settings);
        case AppRouter.registerRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => const RegisterAccountPage(), settings: settings);
      case AppRouter.phoneVerificationRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => PhoneNumberVerificationPage(
                phoneNumber: settings.arguments.toString()),
            settings: settings);

      /// endregion onboarding

      /// region shared
      case AppRouter.chatRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => ChatPage(user: settings.arguments),
            settings: settings);
      case AppRouter.dashboardRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => const DashboardPage(), settings: settings);

      /// endregion shared
    }

    return MaterialPageRoute(
      builder: (context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0, backgroundColor: context.colorScheme.background),
        body: EmptyContentPlaceholder(
          icon: TablerIcons.home_cancel,
          title: context.localizer.underMaintenanceHeader,
          subtitle: context.localizer.underMaintenanceSubhead,
        ),
      ),
    );
  }
}

class AppRouter {
  static const welcomeRoute = '/';
  static const loginRoute = '/login'; // todo
  static const registerRoute = '/register'; // todo
  static const dashboardRoute = '/dashboard'; // todo
  static const phoneVerificationRoute = '/phone-verification'; // todo
  static const chatRoute = '/chat'; // todo
}
